Return-Path: <kernel-hardening-return-13224-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZos55q7mUXYq27+odAlkNR88uYpmgRpxnEEtn0ydYAOjJNcF03V6My4zmUZ3T7f8RpmcE7u
ARC-Seal: i=1; a=rsa-sha256; t=1525516639; cv=none;
        d=google.com; s=arc-20160816;
        b=xhVIUvg5K/tzQpnpv3ttiJvNgFhw1BwJMim/gtVG0ICXV9GiDSjKjigETn6542rkYG
         f/BPVa7nzQa8958dREaYvClDxCLjbVQr8IuGO7reu5ZKbNBMDoNbg61SEySef4884ESu
         kU7wxfhPG+MdAAYdQXkOwKaJPPd7KDCkbjrSzCuzauRC82j1/DBSvy/PDHGFs80iSaqB
         PWJMlSt9UH3RD+4r9wfNvNQ4z1rqvY1XUIrBPDs1nriUZGnE5bHaFIqNw0YEEPALhwUl
         bW5/zJCcbTXs/xUrmY76q6RIDYWfvAADAJ+vMDnjb8LtbMoHblv3Ce5Mqp/R8/4jt7oJ
         RZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=SBgTLAvyQQS8SBaXDQ9fauidERxTWI552chpfhcYDk4=;
        b=ff8ElkuDOjclt/2eBaBLG5xOyuuvg/a22ysk+24EiNDIhvqA/vBZaDWJVkEs2Tayx3
         iWl0lsG0EiZd987NkF1BhLWV/VoftdAzzug2iGC7SrT2btr4fC7FxKM3QFcm96Iuas+W
         WqbbjylabQwX7ecRk7pSfZtVWMGVsJAZdM1gzC+Nue3DFWo/dAyvj9zVFBxksZPvAd/B
         ena907KuY9MmAbfZ6MG/6B27M2OugXAm4egeCPDcBI8yEQuu3UIrBOgzYtshliTMSZeR
         W8wP+Y52GVkM1elc3+KDRm8IWG0N047dHsfRdhbZmmc2pHjZfZ3OUd8Rrqe3FOHlLjAi
         ukLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IzrpX4kS;
       spf=pass (google.com: domain of kernel-hardening-return-13224-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13224-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IzrpX4kS;
       spf=pass (google.com: domain of kernel-hardening-return-13224-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13224-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me> <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sat, 5 May 2018 12:36:36 +0200
Message-ID: <CAJHCu1+V+khxvzhQdG=mo960b5ayiQcSaoMnm9A__51JdWkdig@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1599620135862997268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-13 21:06 GMT+01:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 03/13/2018 12:58 PM, Vivien Didelot wrote:
>> Hi Salvatore,
>>
>> Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:
>>
>>> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
>>> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
>>>
>>> [1] https://lkml.org/lkml/2018/3/7/621
>>>
>>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>>
>> NAK.
>>
>> We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
>> and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.
>
> Then this means that we need to allocate a bitmap from the heap, which
> sounds a bit superfluous and could theoretically fail... not sure which
> way is better, but bumping the size to DSA_MAX_PORTS definitively does
> help people working on enabling -Wvla.

Hi Florian,

Should I consider this patch still NAKed or not?
Should I resend the patch with some modifications?

Thank you,

Salvatore
