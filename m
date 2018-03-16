Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELtS6JmZuK17cXA+cMcceXne+nJ9/iWZs/OWI9lDhk+ORoR+e2jbgCT3+wd2nrkbht8fB1s6
ARC-Seal: i=1; a=rsa-sha256; t=1521225708; cv=none;
        d=google.com; s=arc-20160816;
        b=ybHwQflkIMM0UK74qsWUMQj38R24nUnT4k5k8n5Zo7kBblSEaZS5uWtO3Q29pQLtQl
         2yQdCDLRynZJTZulBK28qyCWe1/BNFp2GvdDS25eElASWC9fXZUplL6y3zHYGXpajlvE
         RjWPIsXD2rTxycFvKISp5jBvKio5EnFIFESgeva538ZlIdNQT7iSwNijCmXn2B+Yj1L8
         UCs2M4H4iXXowCPZ92YV8ct1iJA+b+2igIj47tafcXfAmRZF+4TM7ZDJjD/fccSz5Qmj
         KoCIX84rX9DqLj5Y0ClVziASgpt8PdKNjaJwUg4uMf8lKKHyRtgrE6hqchh3PY1+Sc5o
         1sRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=IPktq7gyd4fRB6Ono6PLZOGIDuV1f2ZfHT1GByvsHpk=;
        b=ZJjGtvKmgE+zza7wMGJTLJVs1z/JuoAwQx1sbqqIQRv5GJn5opNW3MHs6jQVvvBTlo
         /ek2dc5AwdCiij7amm8Hlp/RI8lCgIMufXxm91PRZfqZ5za5nOawERZj8rzYrLP56X/1
         An9LkOb9uBdvc55H/m9Npy5DH8TlAwgpP9QXc+5WbvbP9jjuKExBHMtWL0ZIgSQ/WBoX
         Qd4mWsXUVmQa8a+Zat8Lm2MvWzTKu4eUeEmnxiO+XV9tse6W3px+e2N1YXtL4ZFgJBnl
         S3q3PttBeU7gqs2UUwAFIdCf351pAhcLYO0w/+yb5wY+JOpwa2/krEr0S5wy9Q0VcsRl
         BA4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Fri, 16 Mar 2018 14:41:45 -0400 (EDT)
Message-Id: <20180316.144145.1695554148709004295.davem@davemloft.net>
To: christian.brauner@ubuntu.com
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
 avagin@virtuozzo.com, ktkhai@virtuozzo.com
Subject: Re: [PATCH v2] netns: send uevent messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180316125030.23624-1-christian.brauner@ubuntu.com>
References: <20180316125030.23624-1-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595098694946431538?=
X-GMAIL-MSGID: =?utf-8?q?1595120768234791421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 16 Mar 2018 13:50:30 +0100

> +static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
> +				struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	/* u64 to chars: 2^64 - 1 = 21 chars */
> +	char buf[sizeof("SEQNUM=") + 21];
> +	struct sk_buff *skbc;

I hate to be difficult, but please use reverse christmas tree ordering
for local variables.

> +static int uevent_net_rcv_skb(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			      struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +	struct net *net;

Likewise.

Thank you.
