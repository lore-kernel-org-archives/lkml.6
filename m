Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoQ9kSqQ/WhVv9BO8pv2fy3X7Qoc1Gy6PvB4Gix46CPRl08SgW9MSxHI264GQidCZNrwau
ARC-Seal: i=1; a=rsa-sha256; t=1521484026; cv=none;
        d=google.com; s=arc-20160816;
        b=lns34O9TauNyQf9m5OrTfk2/+G1E82yka6/3tYDGi/qjnxznkPElTYVVAt3Yc5DWBP
         UnDvYMZe5cZl/JyHQKDXxCq0BSi+q7noMSfb2GVOK98VLLThSEsqenCFbnrpyYdeOACO
         vvxjmbKHzfaR3x2N2xNv1jQ7Mk6CfYtowaFfnptlA7ov+BXRdSChmo/f2idB97atLOHU
         DtrK4d2LKtzGhDUKuejbBAp8bT/th3uoYUMja1mVU5IeNH8pN4o7khV6qRNMYbtVPCGv
         mHno5rDpmU1KRDsvGTY5AyNEWwnC/1CxPcgwd/kKXas6R7rvAsQm6uuJoEvsV3y8JmjK
         R1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jyc1PWWrDWsr4pr6pfusJD97futtXEfpfXpAD6NOKSY=;
        b=scve7qhnqn66PRGg0anKJwxaOTJBy9fXQUDpsj4uVGLvRX2Pupku7i9DEeE50N8Nc6
         YR/+9wmWYGzKGiISRa40f6wkyGWuyP4F5+xvU+B7N+fihDc6pDUwuqwZkunExV+3Ippv
         oFOiReLDG5mv3RaywQLBYqZOjWmcI3Bj1NVKgh0T/JeXjqlmxz3X/YU1/G1MzmyY34Mb
         Ee9UEXt1dcCgWd1HUP72kzw4Ue6XiwDVDLePkkdO2wjiE6sa6MqasYvUWhlST9PGoUCA
         YVyydz9cBuZbDL55yonZWSa2wXxvgguPuolJfKl8+ezghGr2uxnfLFXQosdM7L4OhqGW
         qixA==
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
Subject: [PATCH 4.9 204/241] mac80211: remove BUG() when interface type is invalid
Date: Mon, 19 Mar 2018 19:07:49 +0100
Message-Id: <20180319180759.627285068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390631204394300?=
X-GMAIL-MSGID: =?utf-8?q?1595391634388558637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1520,7 +1520,7 @@ static void ieee80211_setup_sdata(struct
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
-		BUG();
+		WARN_ON(1);
 		break;
 	}
 
