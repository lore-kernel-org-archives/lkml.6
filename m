Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/d/aTkYGTkWzWzexFhFoC4tyT4VypKCBVwZyb4rFOqVX8yFoF2Ff5YvwPmpH+ikqwIHUkg
ARC-Seal: i=1; a=rsa-sha256; t=1523021644; cv=none;
        d=google.com; s=arc-20160816;
        b=dkbgbbmMlnFdUTsUzS74cPjwKNvMZCZiD6rxOcdfH2/CyGW/6bntAhimO50odwaw4v
         xznzvMz3HROk67ekX8mUVFbRAt9ZV0Yk1csZhulwxm9yh2jdmQuAZL58aV95M1VBQgf1
         bmKbuhGY7QQaR9p34yWkGRE8IFq7T8KH4MfIqlA4ecLZ/2rOHPgUwA4eiXOu7TtRwGRG
         Mt+N2vjOyefI0XkDOAdX/hUWyTP/jd3Zl7mZLb+D/f77k9mapn7MjydRVBTSvgXI7ifE
         4tTbuHXO9UOTvEaQBSE0DUoHXaCmV5dGdefQstqSjWwOYbWBnNiJeH//lEldDwnbleHG
         jCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GayA/aGEEPHo92JaXZ5/hf0KI1npDTwDjILAV06DzZ8=;
        b=WUX1tHHXsB8HNQP5ge5rzXWNx3+rqwfSZqEXCBDq+UjG6rzaS4Xy1Yv3kcGrchm4VE
         q3wcjROtlioTVJS48KsNkNPg7S2jA2ZISuyFs5R2xQMP5vDwUsS0gJRBYLruCkB9AFyG
         ZPbaOBF/nCSYDglzow5rJJwn48GLC9EDRK9aSCq/EsWTqW6LLj1JRxc7gt89GKEH120f
         lUjym69DyjUdWcCMH0HoZxibuhr4+JRAWO/UlO5OscAO/TGEKqwxZoULbxwRfz6mMz1E
         J212H/Ea3VeSYuzhUviJD0YdkSEKwh2Tm65KiAvJI4zCGmBLBW5hMm+60fDdM1Ptp7U3
         +xeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	David Sterba <dsterba@suse.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 031/102] btrfs: Remove extra parentheses from condition in copy_items()
Date: Fri,  6 Apr 2018 15:23:12 +0200
Message-Id: <20180406084336.040019697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003943312911705?=
X-GMAIL-MSGID: =?utf-8?q?1597003943312911705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 0dde10bed2c44a4024eb446cc72fe4e0cb97ec06 upstream.

There is no need for the extra pair of parentheses, remove it. This
fixes the following warning when building with clang:

fs/btrfs/tree-log.c:3694:10: warning: equality comparison with extraneous
  parentheses [-Wparentheses-equality]
                if ((i == (nr - 1)))
                     ~~^~~~~~~~~~~

Also remove the unnecessary parentheses around the substraction.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: David Sterba <dsterba@suse.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3664,7 +3664,7 @@ static noinline int copy_items(struct bt
 
 		src_offset = btrfs_item_ptr_offset(src, start_slot + i);
 
-		if ((i == (nr - 1)))
+		if (i == nr - 1)
 			last_key = ins_keys[i];
 
 		if (ins_keys[i].type == BTRFS_INODE_ITEM_KEY) {
