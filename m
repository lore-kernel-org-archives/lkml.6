Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+BA3riFwIUNlkolRuBc2FLdE8ELSeoqO2eW6KNdUpEJdbEANFiGfoo+CFBFe7YSu4hFBmN
ARC-Seal: i=1; a=rsa-sha256; t=1523972004; cv=none;
        d=google.com; s=arc-20160816;
        b=psBl4Gp8V8fdglg+TpXB2LB5lOvzVu7h66Vq3xDAqeqjGp6S6Lr75bnS915kapf2Et
         4GDMQgrw+2Q2n8C3W7XbsokOISieiSPHyxYWFyvjJB5SiMcS+xHn2lM3UdZ89pNJPPLM
         kYBgs7NWwuCqViHGVZ+wKMQs5GbIM+rwEoZ2q+xgAh2X8J5p8EoEaeopb3jLdsIQKO5n
         xL9wh9EcwgEzwoqb5EKOHJelSrUD8DznYAmcvIdbx3bJIlq/G8TxAVUU8CKdySq1Okd8
         J4zpIZQNcyTvG+TIs/5Pqj3rEv9JKca9yTkH31XCDvzdCQDjaztq9nL1RTk3Z5Gunm6U
         pmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=tA/l6KfmsoqbREfjfqbh9xKDHR+0/bJIZLFXn9jgeBs=;
        b=gGkstZipEeeyBdy7TfWuJQWV7TcPF67MTbrht+NIG6hIShOmQJLYORj3Oejeo4Oa10
         pdWm+JKSuEqv0+boxvmj2hTxivWYULUOHaSDBJQSf9O75EYbHnL+FhO+v6DiyufGD0Gu
         d4jO0MAl/5LkElqMB2ibkaCK5B+FEudkg7jss7HKuB2gbNW4cZW7nLTRX8eC5cX1oDWH
         KistX9gpXUbRxv2F34bnfLPWDEAPL4p48PRaM589jkT9T+smapkgcywpIu1BZedyp2I4
         CF4hoi+5CdJtm+PYdPK5Fem5Pr9PEGooq5OanY27JzYN9RfPQ3lqUrLe6s415xOxtUVH
         cIrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 17 Apr 2018 15:33:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: 'Christoph Hellwig' <hch@infradead.org>
cc: David Wang <davidwang@zhaoxin.com>, mingo@redhat.com, hpa@zytor.com,
    gregkh@linuxfoundation.org, x86@kernel.org, linux-kernel@vger.kernel.org,
    brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com,
    benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI
 bridges
In-Reply-To: <20180417130040.GA9426@infradead.org>
Message-ID: <alpine.DEB.2.21.1804171532580.1694@nanos.tec.linutronix.de>
References: <000001d3d628$4e91a4c0$ebb4ee40$@zhaoxin.com> <alpine.DEB.2.21.1804171052440.1694@nanos.tec.linutronix.de> <20180417130040.GA9426@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1598000468170927884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018, 'Christoph Hellwig' wrote:
> On Tue, Apr 17, 2018 at 10:54:37AM +0200, Thomas Gleixner wrote:
> > The question was rather to have a list of PCI IDs for those chipsets which
> > have the problem and set the 'disable' flag only for those. That makes a lot
> > more sense than making a list of new chips which disable the disable flag.
> 
> Agreed.
> 
> There are a few other things I'd like to do in this area while we're
> at it (I'm happy to do the work, not trying to offload it to David
> or Thomas):
> 
>  (1) make the nodac flag a per-device flag.  Set for every device
>      under one of the affected VIA bridges, or for all PCI devices
>      if the nodac command line option is used
>  (2) move that flag into the common struct device (or the to be
>      designed dma struct hanging off it in the future) and make that
>      bit handled in common code as there is a common Xilinx host
>      bridge with a 32-bit dma limitation
>  (3) kill of the forcesac option, which was a strange performance
>      tweak back in plain PCI days, which probably didn't even work
>      as expected to start with.

Sounds good.
