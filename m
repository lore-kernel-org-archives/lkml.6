Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4+nSQucCFLibIOK08RSwiq/T8wlgHB6Y2BKjuY7Mrt7cpinBpKbSi4wlJUYy3bUX/m7d77y
ARC-Seal: i=1; a=rsa-sha256; t=1522180476; cv=none;
        d=google.com; s=arc-20160816;
        b=GSNwuqurcz3bIXQbPzRCXW3AuKKh1tMIjHNDhz3WPkHZ7ZE12YsVLSo2aVK2HwePgB
         74ms3D1l74xEws6+6kC7F/XxpePR1DYcXli2fCmsgXPSIZD0fwwSDk5xZVfjmn7o3nOH
         oqlr+Mighf0+gXUpPJlmvkXTB9tbH2PJMvrUl/BjehpmnKyq8DdvA57QAgJGFZgVpZ9Z
         j9qZsY5NdmTGBFR2JNJWDjnNRTQNyVYQ89XJYvBv8syznVpsiXs5totZbM81irp+ccsU
         jk0JgF7XT9Exsr2liJfR0yf3wMY0A/TPLeE1ZqOFUgnibfs7pOw9xB6va1Mtk8x6yGlm
         6L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=l10X6bEMetER7BAPIKEc4SaMNR4HVXBAge4AUuVZt58=;
        b=oPM8kbTgxbTA/tnWpMsuOzLov/KAY7EQ2A6fZycuXCKjEvucwA6xmQisWyoy4t0KjD
         9LnVSeOKrZr8xAj1ftObzPC2x/ofPMLC3yxLlI1VoVfoPZLimBCtcbh/7Mpiaevfae14
         vkTpFJ+iTPdMpDLTxskOVdJyNFS0HL5WJq04N0oyA6X33gdPy5FVthkMmcRZ0xKyzXfV
         QKZJlxNpTUblg6KzkIRXMb9pOP9O6aZkBYZwZZz/vOt1dM4CVAMb5zVljyy/8/TwDKzq
         RLnamVRwD27o8J8xyQbkEuN0Ep2VHZc3vvV4PFcxMcKjemYmhZEYwEHGtHMw+9/UtccM
         Xqng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 27 Mar 2018 19:54:35 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Sasha Levin <levinsasha928@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180327195435.GE9190@wotan.suse.de>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327070637.GX5652@dhcp22.suse.cz>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596121915358590412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
> So by no means the MM backports were reviewed by me. And considering how hard
> it is to get any review for MM patches in general I strongly suspect that
> others didn't review either.
> 
> In general I am quite skeptical about the automagic backports
> selections, to be honest. MM patches should be reasonably good at
> selecting stable backports and adding more patches on top just risks
> regressions. 

BTW other than suggesting we needing *actual review* of the MM patches, are
there known unit tests which could be run as well? Thinking long term.

  Luis
