Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Qjp7U8ZCeXhdZkhQe69ugL5kApQRe7dze9+sJphdnwZUqBk6oZ4gc4HlOF+Oki7E26g4d
ARC-Seal: i=1; a=rsa-sha256; t=1523399221; cv=none;
        d=google.com; s=arc-20160816;
        b=dMRQmWjQHAeacbwJBin70B2ZetlPvjnLTk5Zxb5emG6cbVbOmVk/ADHNvQ1kcTpDNP
         UVFwgAfb4rsQSTlFz9Cht+IaxAutchi9y20EmQ+FH7WucXd6jdQug43VNQvXGlxAGfgY
         hurR8Pc/b3UMg+1CuAuixTtTM8kwfVmoDaE1OrYYTyTR5ERGA4QSY3DgDa+56yFHrrUF
         94rpBzxm1UzYwcRKiaMcEcgL5FXAUD8ajRkcgcww8Fv6opeTp/G37asjOJDIqOGwHzN7
         VRePtWabiVpP4LuzxHG+AnyaQSCJ430oOqhPugmaqMaqaBQT/xNXTEIbBlKv57+XQtWH
         qOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZA5BoGAxtVNlUOJ+eM4dq2n0CkcQnQ03pq8PlL2x15g=;
        b=vpz4KmYE/BmAfMK38Y4JG7UI3UUUfWM8FHHRrL2g8Bh3BWz2fMezYxQB3MFsa9BblS
         M7IPSUgo93QfJYdr5TFt3GJGn8eznQvE93gtDaFXxpFA/avsvwvcH4tFSXmlH+5ySVkR
         +A1R4dDU8wx8AGjsE2sgaQnqf9AsqNVFjlSCaU++RczuBkJc9TzlDNsdh9uoUCAs2bJW
         S1ueroJkw2026YXUlFtTdZXirpRTpbHIKkm4Sg3WS4S0Q0MJ8+OumOwQBBK9WgD8GsdM
         Rba0wGqJEVPGuK9TbT8Gus22IT0QfYYweFI8izaC9Mnau1l1TDgWIcxq2rAv34TviYAQ
         fa/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 029/168] RDMA/cma: Mark end of CMA ID messages
Date: Wed, 11 Apr 2018 00:22:51 +0200
Message-Id: <20180410212801.439772952@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399861846819457?=
X-GMAIL-MSGID: =?utf-8?q?1597399861846819457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>


[ Upstream commit e48e5e198fb6ec77c91047a694022f0fefa45292 ]

The commit 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
removes nlmsg_len calculation in ibnl_put_attr causing netlink messages and
caused to miss source and destination addresses.

Fixes: 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4449,6 +4449,7 @@ static int cma_get_id_stats(struct sk_bu
 			id_stats->qp_type	= id->qp_type;
 
 			i_id++;
+			nlmsg_end(skb, nlh);
 		}
 
 		cb->args[1] = 0;
