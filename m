Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqMXeCXQoKrMGxLaRRr0DV+GTdel+xHxAgtNQ5MnCZ7aKbEyd8TM4WUa6qaATKF+UnyuUBu
ARC-Seal: i=1; a=rsa-sha256; t=1526631654; cv=none;
        d=google.com; s=arc-20160816;
        b=sq1HKPYFk36ZdokDw2QeyxgNCKMU6WPAPPoHbJ5FeYEmBt7RUVvdDhaEn3ttjVqaAO
         5Lq3FI5a+nIcidqgcMxt4Rvw2ZplLof1ebcKN5ZTFFcYIaaOV0Ffmkqs3lu6a6U13dPG
         vEk4jes1vHk3S6/1C2OWjdABIR4Vy6eKyTrv9oO5mfBtHYgnD9kDLgcdsXfDh+ApR/jv
         or2ekyEICyYV12y7kXPpK1/Z7vZMZ9rIthfTujgPCs+FYbQeh0bB/5dXJFaIa9BR4uAu
         lDbLuiUC/Y71A8vBUuDhlM06VJ3HnS9MGTIpsHOxxKsC8hzI6nBTLLvpzNPiHNaG8/CF
         3ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TuvP7OFFwMuf39vjP2tlvsYy61DB21U0rQhJHMY6pqg=;
        b=Qqlk0adxxz3VQEfTd7BEJ4KD5G3rp1YP5NhMgoCEezJ4G1mcWGnfBl7aUcYeEeHvCp
         o+7qYWxNzKiAEgD6+F19x5lZp0t3iNNtyFkXwt5EZE6Xt2tidd4gTukfEGM0DWNVzN3i
         dy0ITj0LULwvL3Tjb6bmOIgzyHjtkpxq5HlDtf5sAJSHMn0yfbHdW39o4oqiUi9xYjWp
         E5v2F3bM3OjMQayl3X8vxeEjVcJHszu68nHtfeLZI4vZhKrf4zNukE2BAbBELKH0CagH
         mT163K68havEDdHHYdyN5TE9P7N/CqgTdVCRdfwonqd8ZoPLIoqovqeSVDP9yuuiW8vd
         n8ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qb21yT/1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qb21yT/1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH 4.14 44/45] l2tp: revert "l2tp: fix missing print session offset info"
Date: Fri, 18 May 2018 10:16:01 +0200
Message-Id: <20180518081532.616736437@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789313790032866?=
X-GMAIL-MSGID: =?utf-8?q?1600789313790032866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Chapman <jchapman@katalix.com>

commit de3b58bc359a861d5132300f53f95e83f71954b3 upstream.

Revert commit 820da5357572 ("l2tp: fix missing print session offset
info").  The peer_offset parameter is removed.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_netlink.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -765,8 +765,6 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
-	    (session->offset &&
-	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
