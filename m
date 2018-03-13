Return-Path: <kernel-hardening-return-12501-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtJljxwgNTzEIuRD75HOO+H61vhHS6bo8ic2YFrfiyXyEVzgDux5AR9vfmY0QjiC92yzBiL
ARC-Seal: i=1; a=rsa-sha256; t=1520932080; cv=none;
        d=google.com; s=arc-20160816;
        b=R0Ps0mrWzC4LOjRNnliNOPD1JzY3d7GtxAPblflHknKEHTTZDstUnhJ8xbYfNV5+56
         j4HycLTHqILHxHk4eX3FrEPTp7DR82PI7/k9yVYnHq0Vto03BvbA5WwkMfKWXN4vtn4k
         awgnrsDXkEbJUS1hh9dk5RLW7U7gk3UWcTWVXax6K7F1cv70/Vo0WninUZd3zE3qmScL
         veboobJbYarmjwJ7skUs9wKj3MmhQ9NkugN49Pb/ao23rl0L3estPipeq27Mx8pJ5Sm2
         CPO3IVePwnymoC340jJSULGXuWzrUnqIeGxVbOu9IY61T3d5RJkli40ZGPd0fr54CG5v
         sW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=wISaWCO7LeztUeQIPmaPstZ1dTlAVRKd7dF5rtTjaws=;
        b=UCtn+5+zDlnnMK1JL0CflSqGMTjZcTHAQ05IsiEPkPlsIYuHq8mGjMG+UdYU3L8qh6
         bI7FncVz+gj+iBWnD6hjeunJFng+zZ4Bk198Wcm9fh9KdIuJvgz8DLaFa1BdOP2KUYSr
         nA1hVyfuzhEjPey7flTPvOFCVw2nt1GCeZktL+kbADEZ22XVmWENNGkiBef+IAhNr3ZA
         gonNCxwXdX75r7Te0hQyLT62kcgz0ehpuH8tPDsVmYZZaENUo1nmPey+5mSCq4PWUAuj
         VKmTtnuXvzdwbFOJWDEx1U2Fp/QbQroNOhuc1HSQywXrbXojEMDEBdAbOplYKdyJNcUN
         O49Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=CDQQsHRD;
       spf=pass (google.com: domain of kernel-hardening-return-12501-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12501-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=CDQQsHRD;
       spf=pass (google.com: domain of kernel-hardening-return-12501-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12501-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 02:05:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Tobin C. Harding" <tobin@apporbit.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	Dario Ballabio <ballabio_dario@emc.com>,
	Kees Cook <keescook@chromium.org>, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
Message-ID: <20180313090540.GA4810@infradead.org>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
 <20180312030834.GC8631@eros>
 <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
 <yq1y3iwem87.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y3iwem87.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594812876942154810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:35:36PM -0400, Martin K. Petersen wrote:
> No objections to Salvatore's patch but I have a slight affinity for
> retiring unused code over patching it. So unless there are objections...

Lets kill it.  And the not DMA capable eata_pio driver with it for
good riddance.

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
---end quoted text---
