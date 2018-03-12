Return-Path: <kernel-hardening-return-12464-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv7BC7PaTKW1p5z+8BcJnOeuP+rWY8pBvWJS7cWIZhquLkZI86ps2YPR0kkCuh4FCjLl4Po
ARC-Seal: i=1; a=rsa-sha256; t=1520867694; cv=none;
        d=google.com; s=arc-20160816;
        b=JgWKCu5/F4fRetkagYhK2TiBooCJF0KJ6gNdAS4UdH4I9TYlPOMBIvzNjMlf33qA61
         DHZGKrQvd660SDlfVsISS7W53Edb3H1LfCMwcE6fg/J1nRw48AjUe5/TlqH34OLxiE0V
         2vnEtyRz8SqG4y1QeYvkzjVuEpltqwhsn1EKembK0qq3qvzpg8mL5E4afu3kf1hDJdmW
         fdY2zYUsF1n7kQplTKzcp3sv9e/RDLQQfr1aBFn4iq7AH0NU9/NKC9u+nx5z879EQgZ3
         mku42Uwk2M7rfEeNAw75RP/k5ELJYL/hIiNC+iYylxlOK81DTDeBPPStknAJhmiqPKlc
         Josg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=bH6vXsPECHxwecxLu6Y7fxaQTnpQc/5Ulc/uzIxiscY=;
        b=KaAFPdhKEKBMpy4SdHMDQE9RNSMcsyg1POhb70Xepozc89OIFsX78smsRxLxoi2pub
         L3kRml4pto8EGxm2MpfIh0zwgrHYwKHQv6JU0/CyWKLiLkJTcnNP8Unj0sBPK5DBRCzy
         kvCPYEMfL5aho1YtPHR8onN+rvWL9+KeS8p076oJuoGLUno6PR+6jM0Bm5gcmk8fVhHU
         O5AnXiB8lpoAHfQBihe5XLZyqeC35ggubNa2D2rdXXwjNsUiWDl/69mf4FUnx01wfItO
         aW/qca2sgutJ2xZQIi4phhGKAfwJPEhyADgM4tcgL7hoesn2YTUPg/YSyZUblVe6kTEz
         tSlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12464-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12464-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12464-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12464-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 11:14:32 -0400 (EDT)
Message-Id: <20180312.111432.849792523664957837.davem@davemloft.net>
To: s.mesoraca16@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 netdev@vger.kernel.org, paulmck@linux.vnet.ibm.com, rientjes@google.com,
 elena.reshetova@intel.com, ishkamiel@gmail.com, keescook@chromium.org
Subject: Re: [PATCH] net: llc: drop VLA in llc_sap_mcast()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520802724-17509-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520802724-17509-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677285477224056?=
X-GMAIL-MSGID: =?utf-8?q?1594745363322534346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sun, 11 Mar 2018 22:12:04 +0100

> Avoid a VLA[1] by using a real constant expression instead of a variable.
> The compiler should be able to optimize the original code and avoid using
> an actual VLA. Anyway this change is useful because it will avoid a false
> positive with -Wvla, it might also help the compiler generating better
> code.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

Applied.
