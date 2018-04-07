Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx4+RfSyH53aJh3mtV6s4FxKlLNY2iNKjLkWCMzDA0/SACl97N1axRU+JF2fC5rEntk+hg/OZ
ARC-Seal: i=1; a=rsa-sha256; t=1523131872; cv=none;
        d=google.com; s=arc-20160816;
        b=gdNwB64VMEUtH1md3wDzZM/koLENrmV5KL9VhQZU6kLwjnNnRlSfygSqdFTGDElM5y
         CtaJsYq0zMacrwWtoHY5l7q1j8ExcjA3/KNT0V2x0MtXA/hyXzLu6d0/Ula81T57ht27
         tPiMRH1C1GTwwH4uh36XQLDzkYCSerrN+9/fvUOn8nQA4ZN7Xk370WOvBkINwgQedk5H
         N57AJHyIq9GNboFLzHvK46EgnErvSOAtbG7rpwgLLSbbLvjhMCb4rqFA2zWT4eMAcmHP
         /5IR/tsGND83HVr4MTVhMNpSEgsx7UocckMnhIAVV3KiZmQygN7mACMomm9dKQXeOkxD
         5yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=9/WmfVYpbUS1d6wVLIVfzkn3pAm2Wx5U3uX0PG37X7w=;
        b=Nh6PmqQWDFB4WijUtHL2rMCpfIvf1aLGMCqwa8rGvX12fWSW/JQGoNKLkpkd7UsNRB
         XB9L3mCDX6E/FTz2IOUaj2HAQzGNhwAVC41n0rHXQpM1f7RB5wRDrUVUAnzJF2y1yGzd
         s4eaaOaKtx1T6ZmkR2S7f2xSMgFvQSF7vVmTXJSzVkQL5phxyLJKxBKn6KcNQTLnEibY
         Ijci3/uWYPDCLqdzg6nd3YsG0K0CWO/7QwR8APjxbnCMp+ADBEIMeivNbfp2lY+dcm0c
         o+EQl8NldrwHRTB51Tm2/GlDBc25iMctv8+oKZzI7Sv2rSGZZ/MRprDbSH23MQGDjgfi
         Etdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.130 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.130 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2110:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:8957:8985:9025:10004:10400:10848:11232:11658:11914:12043:12050:12679:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21080:21324:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: moon19_7e8c8be1d0759
X-Filterd-Recvd-Size: 1506
Message-ID: <03c43ed43d0ec3ab42940bfffd4c3778bf5d0f11.camel@perches.com>
Subject: Re: [PATCH 1/3] mm: replace S_IRUGO with 0444
From: Joe Perches <joe@perches.com>
To: Paul McQuade <paulmcquad@gmail.com>
Cc: konrad.wilk@oracle.com, labbott@redhat.com, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, guptap@codeaurora.org, vbabka@suse.cz,
 mgorman@techsingularity.net, hannes@cmpxchg.org, rientjes@google.com,
 mhocko@suse.com, rppt@linux.vnet.ibm.com, dave@stgolabs.net,
 hmclauchlan@fb.com,  tglx@linutronix.de, pombredanne@nexb.com,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Date: Sat, 07 Apr 2018 13:11:08 -0700
In-Reply-To: <20180407184726.8634-1-paulmcquad@gmail.com>
References: <20180407184726.8634-1-paulmcquad@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597114285663933591?=
X-GMAIL-MSGID: =?utf-8?q?1597119527013372411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-04-07 at 19:47 +0100, Paul McQuade wrote:
> Fix checkpatch warnings about S_IRUGO being less readable than
> providing the permissions octal as '0444'.

Hey Paul.

I sent a cleanup a couple weeks ago to Andrew Morton for the
same thing.

https://lkml.org/lkml/2018/3/26/638

Andrew said he'd wait until after -rc1 is out.

btw: checkpatch can do this substitution automatically

cheers, Joe
