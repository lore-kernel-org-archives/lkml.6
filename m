Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRYyHnV2sjdKh19UDeOTpBZQZycFgbV8ZXTV0+rF2ZEaoK3SjorXnROqfKAdmWUPLNNFXj
ARC-Seal: i=1; a=rsa-sha256; t=1521483069; cv=none;
        d=google.com; s=arc-20160816;
        b=WXSuEYdqflJMp38oB+wOsVjlJCa4oGydfJC0z24Sa/1UWbdPJwyseaJBydYR5nq1ex
         Rm/JpCqpHrIgk0Ki6jSlaP9f+LdoenKNBe/fZTI5wbuOm3fTg78i0QBbsMZ7SPjBlOeS
         6omzAWFsGO3LRKaFImAn9xmXN3MkDRpvfR54RiDg8Hf7M6dqMOrNhgpw5HR6RmvTo4Vc
         UhkcV+X9i9iS/qDOro8BpDoXn+K6oKzNZgWStic+qVcnQfGHk6O2nMid6xy2zeWKF3S3
         dHC4rlA7nmuqegoUsGR9xlI+arEccyUymOBpkj2VTECJdXwtgxNUNuLX7lexY3vYI5QQ
         50mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F6V617vEwh7ek7Weslp6siCFc64bVhBu1/dXbdlY+Ns=;
        b=r+pS0yHsNY27BcplDWsXJS0+vZLl4O3mykE1MqlzIpvToojpDeLVfc8n7AVXyBvqtq
         okx+dLDCuJgtpJVpcI3yqdJ3xue8TAmWsj9hYubWgQ8doQpjkkGIjG9CrnugSQ1Zf+tS
         AJyxOz9LUX0+/1mXOPvUA8QbnSqGn2uR9sfgxP2/SLnVMnxpiprSfy9E740mypzstBsP
         1NfygRXLzTRy8Veo30hkk0eG+bRfEwsz3FtJMomfyLp+yDjNV4XqLwzpSusi+hl9SgfG
         PXDP4vuwk0v7AlaIS7Drp2FPj9FyHPOyYR/9jTHLSgF/fsOgqLjtaY22RqnQtQy54muC
         OOFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 56/68] mac80211: remove BUG() when interface type is invalid
Date: Mon, 19 Mar 2018 19:06:34 +0100
Message-Id: <20180319171835.729806847@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390631204394300?=
X-GMAIL-MSGID: =?utf-8?q?1595390631204394300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>


[ Upstream commit c7976f5272486e4ff406014c4b43e2fa3b70b052 ]

In the ieee80211_setup_sdata() we check if the interface type is valid
and, if not, call BUG().  This should never happen, but if there is
something wrong with the code, it will not be caught until the bug
happens when an interface is being set up.  Calling BUG() is too
extreme for this and a WARN_ON() would be better used instead.  Change
that.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/iface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1379,7 +1379,7 @@ static void ieee80211_setup_sdata(struct
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
-		BUG();
+		WARN_ON(1);
 		break;
 	}
 
