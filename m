Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunusKtJUSmSUBghtvYXiSOGe5Uqs1YCzZw0VSrwuk+IhSy9P9+RgW/TJdTM1NqIwq+jsZN
ARC-Seal: i=1; a=rsa-sha256; t=1521215105; cv=none;
        d=google.com; s=arc-20160816;
        b=y/jiiwPjgxBnXWysj3g8wjQASRn84GIAWoO43o4ofDQKvZvdMDflDMu8UoLhtKgUhW
         reIvtIelCYadLKQvjz7mqSJQgTvqMOip8MwfEZ/NGp5nGSuGAAbr5G/QafIx+djFxO4f
         g0NZnj7UTGXKBJGFYYIk/n/9V3ShElpTa5s1s02uLvj4mhP5WmcJsd0zKeQ6Wv5zPxzK
         B/qt6w9p7jbYLOH9twEqdZxDf+iChLOj5S0ztLTvJ9CF5nu3N6QNUmqH6rCbzrxZT+G6
         oyMkTo9qdyVQt8CJ0+vOmwAkikGy6y2x3LHLcW0O3vl12B3pGo/ncRVTrthOCLiz/x5V
         dSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tAuOSwzdnQ3Fk6x4+O8iq29VcAkUduK80Bdn+YnvSgM=;
        b=WU+nu9JudL5R6E951YxUc1VV9plA1HGqcB3n7I+csCfzWVgvRHNT433OXyF5iXo50d
         sySPlgmqjX/XyEEIN4VeP/KZpJc4RzMiupEqmTd0TDB/9JSyEkmd3ffayx8SOj9xDD8c
         3vghcMAqWU1WhAIDTMp6lExdMjK5p5Q0tG1h6gV7lLkuJH1AuzrI8J8sBV1OcGpIfAvi
         3xn9mAj8rcCc0Xyh+GpOROIvfyUYr5+OARxcweiKRU+qW1aWHcSzUpEXPET5tzndyjRR
         8kWFx57WttPHLVUaSaA4chvMDEhpbm98Bgh1VmmUewiYTv5ExfrK1jikxiB0UQNFxyRk
         Sszg==
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
Subject: [PATCH 4.15 117/128] mac80211: remove BUG() when interface type is invalid
Date: Fri, 16 Mar 2018 16:24:18 +0100
Message-Id: <20180316152342.303786912@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109229547793533?=
X-GMAIL-MSGID: =?utf-8?q?1595109650360579920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1474,7 +1474,7 @@ static void ieee80211_setup_sdata(struct
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
-		BUG();
+		WARN_ON(1);
 		break;
 	}
 
