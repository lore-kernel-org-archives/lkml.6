Return-Path: <kernel-hardening-return-12520-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtYRee2kLeNSnWqSH0kdxikrXkyAWOTf2Rp0hEG8itCXGvgrZmW7ckv59InLf6fytholPav
ARC-Seal: i=1; a=rsa-sha256; t=1520971840; cv=none;
        d=google.com; s=arc-20160816;
        b=Tba9FAWNfSuhSAoo0vraZh6bkeilyGn18Qre5yjxtmv+lOFvAV+MRSTUPoQ9FwrQn/
         ccbE2avtk+KnZkKBO0KJw+mEvlaA/Fvjr+aoyrEPIG9w+V9PimbhQzjWHhfVk7apgBAK
         msN3D4f7mEyHYm2oMMWxfzHUNxYdkPmeMorL/tbH49ivu4SqkpBhtsgAonRy2jSmLi9x
         ZxTmuvE87xB+gnVlf22jRDnEkXzHerQqQ3WzJjDWj9d9rsTTQTnGrf4rt3y4kYGmOcxt
         KbJHdp5+MDWSp4bEKKY5ybnkegG5kNOjAdkJoI6jGCLcKapai56mWtCrv9TTBmLO4Ig2
         4sBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=itWdWnS6s+MGaF9vnIXJL88dHgddWegxSQ37NdhRwqo=;
        b=EM5deWuB4U2y+PUcbUdQuFQiYbOGFnivGSHifEehVvYW/sKi1+YGmF20fbapaV+zka
         DeL+9PpGNPj5v/+857x69SQBDzaMLwtkU+U+uwNk5E+wSF+Dv4nCA+ItA+I5T5xjigTB
         yH0jVkme3UpDmEGZqy9v5qn9QoWBqfCDk8in6Km22W30oGP2yLwJEA5gKWAgJQ933sEP
         bR2++8W53CyyT8PATiWGsg5KnKN+60nM88rJlrQ0q+RnwJEfUIhlPonadBVM0lZjitdd
         pEbg4cWpwIhaGzG5o+Nw0KcanSM3Ex/+8jfp4GA+AimX2PG4o41P1KaQEY01Ip9pZi1d
         6LCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12520-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12520-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12520-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12520-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Kees Cook <keescook@chromium.org>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
In-Reply-To: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
Date: Tue, 13 Mar 2018 15:58:53 -0400
Message-ID: <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594854568991072159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Salvatore,

Salvatore Mesoraca <s.mesoraca16@gmail.com> writes:

> dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
> 2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

NAK.

We are in the process to remove hardcoded limits such as DSA_MAX_PORTS
and DSA_MAX_SWITCHES, so we have to stick with ds->num_ports.


Thanks,

        Vivien
