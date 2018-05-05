Return-Path: <kernel-hardening-return-13225-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZowAju5v0NGk0G7Xo1AfSx5WDgJxUxk6JCMPlnPB3KfzkxH8VVMALtS3eUrPCHoEE4zMFF9
ARC-Seal: i=1; a=rsa-sha256; t=1525537978; cv=none;
        d=google.com; s=arc-20160816;
        b=G2mexSHEzVk9O5Zz+TDZ+9T7yc95i485tJyUSJmtsDMYeKuTwM1G3qoaJCXdmPDwx3
         SJy/rDIuB1rbfujZin7RKDyUTdPcyeVvBRBWVtz6SzXXE1gK9998myoQ0dZICZHlDnfE
         wBUZ749xHgEPnoj8El8GV/aFqaGkifHrYMb2pudQugn+OmilNuH5bFgYNXm3ZivfLTIf
         nyzfjHGCrcbLcrfWuUCqcJnalqARae8+gZ7tRuD0AiuZmgxuAN1W9/pwrF//FhPBvri+
         ppV2c4Mx1O8pPKwcgFUl24EfVkjJwIcVlckqXoZ3l6zt30H+IlS0fzB/0ZIu6Prr2aYx
         +tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=fSeQhtOTOdIc2wF3kF5t8KgjybOwR6Hp7EfPnTo7ikU=;
        b=EA8OgcMkzAGh2Yxr4TB3SVv0Hph66T6FvnF+lVModKLlKcSlOCqMVuAy9+9pmitbTm
         L0nwZwyDtNaNrLpZAUaEgBVJOZdJcQFihm7k0hA7XMa+ftWozZ8h6rL25jx8MqMx7xs3
         xQ5/mR4oO8g9zSl86fTkSci19wc3pT0Rts4lQGDT/6LTSrV+fMTLLIDKk14DCYd5R7MZ
         Z9szvSvru+BJjPwoYK0k3Ivz0UfFhTwHAh5tjKuCVO+Q3s000xe13jbrcW7tcKZQ5aKd
         1/eNbCdczVUfJ48kM7JH90uS+2d6Uwf39ckIsvisJOuO6QsHkAxHluGsLGulQMCOxRUw
         nlZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=We58WLaL;
       spf=pass (google.com: domain of kernel-hardening-return-13225-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13225-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=We58WLaL;
       spf=pass (google.com: domain of kernel-hardening-return-13225-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13225-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 5 May 2018 17:39:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
Message-ID: <20180505153905.GA30439@lunn.ch>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com>
 <CAJHCu1+V+khxvzhQdG=mo960b5ayiQcSaoMnm9A__51JdWkdig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHCu1+V+khxvzhQdG=mo960b5ayiQcSaoMnm9A__51JdWkdig@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1599642512183256575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 12:36:36PM +0200, Salvatore Mesoraca wrote:
> 2018-03-13 21:06 GMT+01:00 Florian Fainelli <f.fainelli@gmail.com>:
> > On 03/13/2018 12:58 PM, Vivien Didelot wrote:
> >> Hi Salvatore,
> >>
> >> Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:
> >>
> >>> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
> >>> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
> >>>
> >>> [1] https://lkml.org/lkml/2018/3/7/621
> >>>
> >>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> >>
> >> NAK.
> >>
> >> We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
> >> and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.
> >
> > Then this means that we need to allocate a bitmap from the heap, which
> > sounds a bit superfluous and could theoretically fail... not sure which
> > way is better, but bumping the size to DSA_MAX_PORTS definitively does
> > help people working on enabling -Wvla.
> 
> Hi Florian,
> 
> Should I consider this patch still NAKed or not?
> Should I resend the patch with some modifications?

Hi Salvatore

We have been removing all uses of DSA_MAX_PORTS. I don't particularly
like arbitrary limits on how many ports a switch can have, or how many
switches a board can have.

So i would prefer to not use DSA_MAX_PORTS here.

You could make the bitmap part of the dsa_switch structure. This is
allocated by dsa_switch_alloc() and is passed the number of ports.
Doing the allocation there means you don't need to worry about it
failing in dsa_switch_mdb_add() or dsa_switch_vlan_add().

	Andrew
