Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526579297; cv=none;
        d=google.com; s=arc-20160816;
        b=kjXAAol8kJaP4Zoa9CbJJnV8868P0CFFx2XTaRvNgQLLZ7MbF6pBxOUobTTO1USPpL
         ydZNvmnsZpSeLEVtQ5NASUA7dbgThKGc9LlhqH+UvecfzdVwWKIn4DsiHjwtJZ8ZmepZ
         qfNMdMX47cPGsO1+S/n4DzP/s0arugnCRCx2nxonw1+eiRPMQ87BMjPRlgNEj97ubUvv
         QbpLsu54agjvuiClMKk/kfCai25DWClloTO0CPDOxYEj76nIdz4vmZq9GjqgtChTfqrT
         7Op2yM7P/LI736wYaGu8mdPaOKqZQBql2vqFhFx8CK/I4X/G+dIJ+yAtAjMtqfiV0Vg8
         ubwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cX1OIOZxPG5BEsFIQSJ80Wk+Xdu+73H54j2PPDAFec0=;
        b=w+NBvr96CjFT/0LUJqho3SfERGwY6DXakTeEtuwGqRVTTom3zd819eu5+dAeJE/mfo
         QVrsSs3/6RIv1yqsJHhkuBAXGirBlbk1gq+F7TSlJBqXmgb3XQldmm3GWCwbDIF8SuLP
         MK5JFSaTQ6OCdJk5dvRMPtvqq/TAIzg5Zo7TNARDUdRqMBekHNNUAMddIAF+bQuQ2ARg
         Ykovh9/IkTQlb0G6wtpSUO4YpqJslhlRqow/Zrmo9cEYXOW45vkkd73dDTtWe/6y5mq+
         bau0pcddp59KK3M1VIBydtNd7JQOHC4hNq9AOJKIDwR7G1VO4SQdNedZc4rTaB19uMYN
         G4iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=do+U1vgI;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=do+U1vgI;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrhCIn3n/Nwxtidw8/7M0PalJABH0ULxnSAQf5wHX2PC+0rb8Jt2PQ0MDUdHoQjh8eW4IWSOu4PEhoNVrSM4M4=
MIME-Version: 1.0
In-Reply-To: <20180502.110841.378324128079268584.davem@davemloft.net>
References: <20180501174122.11323-1-grygorii.strashko@ti.com> <20180502.110841.378324128079268584.davem@davemloft.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 17 May 2018 23:18:16 +0530
Message-ID: <CA+G9fYv5yXD4_hyUSxWra+gxux1NFv+sD2HgB7LyJ4E78bgh+A@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode
To: David Miller <davem@davemloft.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, nsekhar@ti.com,
	open list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600734413444103525?=
X-GMAIL-MSGID: =?utf-8?q?1600734413444103525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 May 2018 at 20:38, David Miller <davem@davemloft.net> wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Tue, 1 May 2018 12:41:22 -0500
<trim>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Applied and queued up for -stable, thank you.

4.4 stable-rc build failed for arm32.
MACHINE=am57xx-evm

Build error log:
--------------------
drivers/net/ethernet/ti/cpsw.c:
 In function 'cpsw_add_dual_emac_def_ale_entries':
drivers/net/ethernet/ti/cpsw.c:1112:23:
 error: 'cpsw' undeclared (first use in this function)
   cpsw_ale_control_set(cpsw->ale, slave_port,
                        ^~~~
drivers/net/ethernet/ti/cpsw.c:1112:23: note:
 each undeclared identifier is reported only once for each function it appears
 in
scripts/Makefile.build:269: recipe for target 'drivers/net/ethernet/ti/cpsw.o'
 failed
 make[6]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
scripts/Makefile.build:476: recipe for target 'drivers/net/ethernet/ti' failed
 make[5]: *** [drivers/net/ethernet/ti] Error 2


Complete log link:
https://ci.linaro.org/job/openembedded-lkft-linux-stable-rc-4.4/DISTRO=rpb,MACHINE=am57xx-evm,label=docker-lkft/205/console
