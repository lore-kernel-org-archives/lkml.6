Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4958kq6uglnwzeR8T4Z/ZPR1I3vxz6ttyCFQa7a6ooT4Spp/I5UwrU+6Bb6HGHfiYjE2B6+
ARC-Seal: i=1; a=rsa-sha256; t=1523399676; cv=none;
        d=google.com; s=arc-20160816;
        b=Lqmyx5s4qCwV77SrMQSpBrYsmhn9AMaqMwtDk+iHb5Amu1F6KK3IXarSdCh6HCtnai
         Bd4WHHQSI8CcM0q+8ObaJAmS7kcEvcTf9N8/KSas+6miXQugZ9r5Bhh+r8bzbBZ8IetL
         CvJ4OEWiFP5q/J++2dUPJwiDPs1j172uk5jQyjBkfFUNsHKr+NUPX+783y9CU6bV4JgG
         2mhZ+qxcl6X/UC+f6DLTsL7oawZ3MLRm355hbiFMnZxgdTVUffSY+mICn333s7x94FEU
         aXOEh/+zm15x9PLfL2LTjzuVEJmciMXvc05W22j/VF9Y+eXVGJfg5wTPXBtqKdC1XJNq
         +tRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Ryogu9M8NVamZMxwPTEWuNB5hrtz+WYd2ciZlM4C8w=;
        b=JQTnMSBCrEPBP2t24mb6TyG1F9wpHQiN5Pfj9hPj4ZYSy0o3g9flvq660m/mvJWCLM
         LL2uT0h4ScAcXvNNMelSZno2LjzChH7bgAQkMtb5BMFC+bl4U0+W/UxPy+atCR2J1gIw
         YK6e3zX3t7olAVeG0+U6NtqJJbvB0w9VZcw3k3XYagtCmze22Z0dRf8Z6I31IstoAJl+
         cifQtyACOkXfZXOlgfnuBIwTdgS+iE3td6Iqk0vPau1Jz6cRbS7UmhLOOGzeimLOd3cX
         X72qf9KApDoPyo5r7Fw5wqGXjyMBP1SeD22QXmPXQ9A8T9cjdTCph1VgOD348MTMJawo
         j5MQ==
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
Subject: [PATCH 4.14 023/138] RDMA/cma: Mark end of CMA ID messages
Date: Wed, 11 Apr 2018 00:23:33 +0200
Message-Id: <20180410212904.832231974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399861846819457?=
X-GMAIL-MSGID: =?utf-8?q?1597400339257697041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4453,6 +4453,7 @@ static int cma_get_id_stats(struct sk_bu
 			id_stats->qp_type	= id->qp_type;
 
 			i_id++;
+			nlmsg_end(skb, nlh);
 		}
 
 		cb->args[1] = 0;
