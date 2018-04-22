Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/xa6M31W7vO4Fed0pKLxsfmgCPpwEJyNjkacV3CzBBYokyjclqR1bX6cJjIw76Y0t6paxF
ARC-Seal: i=1; a=rsa-sha256; t=1524406441; cv=none;
        d=google.com; s=arc-20160816;
        b=LRt8binJEeOlID2Y3OKx5XwRDYyiYP+NJmiFVSM65nzQC47M0m+IQg56QCqaLLIZQB
         7pAPbBLgDaD22o5f2E8SCnjukBXSwu1GE5/aoSFdlbA6fN5s5a6ihaqDoEL2N9O4ly/R
         4dQ2zR35g+9RK7rsRPDR18qp5gApKjs67D/iu0kregifILwECoK4svvbLiCzUNTzWmtO
         AFFuF+ZF+f+ZoQM8kLFTNpRw6p4hbl7Teu5q8x/dw7BnYgCxvYunSiN4jGBOd5nYaOnY
         e8VunYEJxToNS52+LYBIaBEnHXAXb1VetdOt3obQVR5Z5iha7tK9IwiqMRMfy2gVcEmF
         Dfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ginU0lqF7ed0hzAj0JTtR9HtDpDT7MTJdSGzo9dbxm0=;
        b=hUfS8zN4F6oKHzq31FG55EHas8/hkt+umQ9mVqnYWDJsWFrpEAFnwjkiwdt1LxDI19
         9Kqf1nPruEk6iYNVU9/aoTJA31Gy4MHfboGPyt2CJtX2NEH1hnr6OoYH5B+TNCDcAdj1
         N5AD+BxvCcKkNjfZsgi8/Gq2A5pj/05N7Ed4mQnIviZo4MkG6Es93llWjmcab6fist4Z
         DrtIWeKm3ctUqlPgIr/j2w2Ry1aUHgBtKWIawNwWfRSmfKMLZzxpuxmBNTF/sZ0nkWjf
         OuZaj1qmCOpIhZ+zx0hwSi5b+HzOlwvfYu/ynnOWIzkd/CT9uGtCG9OAlwL8ZY1PSuyf
         oTeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Wang <davidwang@zhaoxin.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 73/95] ALSA: hda - New VIA controller suppor no-snoop path
Date: Sun, 22 Apr 2018 15:53:42 +0200
Message-Id: <20180422135213.414667899@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455325045223483?=
X-GMAIL-MSGID: =?utf-8?q?1598456008405042391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Wang <davidwang@zhaoxin.com>

commit af52f9982e410edac21ca4b49563053ffc9da1eb upstream.

This patch is used to tell kernel that new VIA HDAC controller also
support no-snoop path.

[ minor coding style fix by tiwai ]

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1514,7 +1514,8 @@ static void azx_check_snoop_available(st
 		 */
 		u8 val;
 		pci_read_config_byte(chip->pci, 0x42, &val);
-		if (!(val & 0x80) && chip->pci->revision == 0x30)
+		if (!(val & 0x80) && (chip->pci->revision == 0x30 ||
+				      chip->pci->revision == 0x20))
 			snoop = false;
 	}
 
