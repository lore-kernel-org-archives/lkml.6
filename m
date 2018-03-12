Return-Path: <kernel-hardening-return-12426-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtKTYwN4jzg4AE+05MDi76FwQZTnr+mFryB+v2ei3JRUlo2amMyzAeNQ4OFyCKvur7zaAnv
ARC-Seal: i=1; a=rsa-sha256; t=1520849616; cv=none;
        d=google.com; s=arc-20160816;
        b=CKOFSjRuovO5sYQuCw0kWd4I7TLN4PH9YZwCZ0sLbbYW/TmobyGEZ4LurtAheD7nEq
         +4183dUy70tNxp50Z+fmiOcdQoYEGvN5svYIM1cDaNcpE6FF64wuiz6XNJl7wH6xP8yT
         VqfvMlsjov/Bmd1mTK3nH7EGmhcqhir+4hVoaCIjRip1muOcvn3lVterfj0P8gma/fcu
         sS8IqGgP0kNdxXOZFLyAd++nvspqPVpDoFs9qfi0i5JvQKYho9Drv1wMEDvhz4jzi4k5
         KSlRoUra1+au3fYjAKcmyliJVn6JoZBx7O6U+oQVM/7RD5mhrsKPQT7V6Vo9I17MTU6t
         jy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=XXPveE62OKQLDLLQ3b2NDFb0MaVNKYb+uxCkrpyhE/c=;
        b=rFWyeotUxbTjOMaveRUyjosnDpWepafAm2aFq6vOb7WdvuFer3Bh97Ekcp8R0Adklk
         twDAVV//WIXOWjsf4bwAL7OJ0TWmgaiuuqsnqzQH9Vn5SDwEiAPuyynj/hheAgLY/2PW
         n5AWd9a1rQ71d89lX1eG6Ol6wLRW7t+U8rXjSvPvj31IGAc3R7pCvTEjsfjlPJVeRG8k
         oiE/mfnyhlZFVm7TJ/TnIioBwAfJVL2W3JO1OxmYil3T/vC+p6xXhM6mIx8AHFR0dqab
         wsL6r3/wAptmdXrPPE4bR1IY5L4G/tm8fbt+uTAf3NDWkMeepElZPAtG2Pfs4ZuAP4L9
         aJUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qTF+z52m;
       spf=pass (google.com: domain of kernel-hardening-return-12426-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12426-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qTF+z52m;
       spf=pass (google.com: domain of kernel-hardening-return-12426-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12426-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <9f197147-c050-dd70-23ea-ec880d205201@oracle.com>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com> <9f197147-c050-dd70-23ea-ec880d205201@oracle.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 12 Mar 2018 11:12:57 +0100
Message-ID: <CAJHCu1+afx1jMA1eAsEdrqLBN1o=ndQUXEheEteVw+VHEwZJdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: rds: drop VLA in rds_for_each_conn_info()
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677115997192072?=
X-GMAIL-MSGID: =?utf-8?q?1594726407859853770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-12 8:06 GMT+01:00 santosh.shilimkar@oracle.com
<santosh.shilimkar@oracle.com>:
> On 3/11/18 2:07 PM, Salvatore Mesoraca wrote:
>>
>> Avoid VLA[1] by using an already allocated buffer passed
>> by the caller.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>
> Thanks for both VLA fixes Salvatore.
>
> FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

Thank you very much for your time,

Salvatore
