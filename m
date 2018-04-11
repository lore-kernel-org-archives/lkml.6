Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx4/Rz5cIEl1L4z0MGxLweSNwfjE85x3cHccUy9A/rovudzK5nwT1c9ba/h13HcSxa5AVpEm1
ARC-Seal: i=1; a=rsa-sha256; t=1523427332; cv=none;
        d=google.com; s=arc-20160816;
        b=kubcv1DHRLFhgRvCtqbW4BEugYQw0JVE5Ew5ztmdKPSLFlXlPR0t4SzFGIO7jDCEOc
         7lBdbvwf/Mkj28hZ3J0SAuNRpX9ncnVgmfDOB9d77j54GlSzT2jA57WQtdzKI38Iqri4
         hXZpcKiGZsTGWCXQIkWjF6Vh/aUTCkSKvbISR0skxPtfnq3oet9tzVugasOQsYkbYZcd
         37g7wzMeEF1JJLUMl8uoMuAml1tv2l9QZVyYltit4SUvJvNFrSXhJLr83FAhDPC82EHG
         j1kuQDqCtSD4gF/eXhvaWMupUAtgNDTJMjeKAUFForeX7dvktBwpukNbWANTF4EBifQu
         BeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=jroLJ2g/43i0/6oRUPnmF17py6Y+NOVnnuuuOoqhnEw=;
        b=OLoc/s9g9zm68WPCfT+SX9MgyZ2g8fKqwqM4N7CU/MvPMdDsRyHnn9rtPUTXfQbeuW
         gr/a+3oU3RF3TEoeNHJYo+OVvUJyqHda7KPR3F1LCaICCzOPv/HHZlug//SUFb5L/bDi
         900d+rgreaT8CqNx9MvCYN95xrYlwmOTxrDmrVcA8OjkjxyCqDS3whLTAjN17mB88JRf
         94CmSZ7M7qi5OxOYVN/SC5e3nzFqdQmfA+BA3FLaodP0hNb+wG/CoHg13ewXRLNvYHte
         eLq+Ycb6PcBxFi+OIYBptwl47DcP3M0Da6jFBKeuDNRcuyHbVWckQahiWBl4ERrvwe6O
         CT5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.166 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.166 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7875:7903:9010:9025:9389:10004:10400:10848:11232:11658:11914:12043:12295:12663:12740:12760:12895:13069:13172:13229:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: burn12_300ac860fe85c
X-Filterd-Recvd-Size: 1965
Message-ID: <15d2961566261c1b9428402930fd3f994c7f472d.camel@perches.com>
Subject: Re: [PATCH v3] isofs compress: Remove VLA usage
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Kyle Spiers <ksspiers@google.com>, Jan Kara <jack@suse.cz>, Arnd
 Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Greg KH
 <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 23:15:28 -0700
In-Reply-To: <CAGXu5jJBqiXZzvRaoXRVuxFckaFJq+LfM227t2uXF3vhwE7WPg@mail.gmail.com>
References: <20180410234532.185426-1-ksspiers@google.com>
	 <20180411003331.GM30522@ZenIV.linux.org.uk>
	 <CAGXu5jJBqiXZzvRaoXRVuxFckaFJq+LfM227t2uXF3vhwE7WPg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597429337749396102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-10 at 17:51 -0700, Kees Cook wrote:
> On Tue, Apr 10, 2018 at 5:33 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Apr 10, 2018 at 04:45:32PM -0700, Kyle Spiers wrote:
> > > As part of the effort to remove VLAs from the kernel[1], this changes
> > > the allocation of the bhs and pages arrays from being on the stack to being
> > > kcalloc()ed. This also allows for the removal of the explicit zeroing
> > > of bhs.
> > > 
> > > https://lkml.org/lkml/2018/3/7/621
> > 
> > Do you even bother reading the feedback given to such patches?  I'm just
> > curious,
> 
> He made a tool mistake (sent v2 again) -- please see v4.

No worries but Kyle didn't just mistakenly resend v2.
It was a v3 with a different below the dashes changelog.

Kyle, it would be good if next time you were to add a
listing of changes in each revision below the dashes.
