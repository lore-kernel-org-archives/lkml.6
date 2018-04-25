Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/hMaTRfRR1YGu1ryq+EbXHxv9VIn3MGv/4LqANgUGSlwWdjKdYaf5DaLOaa33z8ln3TgFa
ARC-Seal: i=1; a=rsa-sha256; t=1524652931; cv=none;
        d=google.com; s=arc-20160816;
        b=eUZAAD7yy8IVzQ0zPhKiKwW1ghmL9iEk6F+12AcQ6UMbOrpegnGt7KMta+BfGJIi4q
         bw/Ap+MZkwBgtfLjJdIKOH9qp4pMD7ZByydXsyuEo7VtsDZFgEiodrz6dc+vF0jnJ57t
         ALjrO2Kmp//P5jDAcK38xYpTxw7DVd7oCb7VHSW61KiwnsFT6KBl6sqVf+xfLvBEM2ri
         rRfn9dP9WZaeFVDRweJiKJUk57f4gxap/vyjNveEQ58fWI/lU9sd/NkkmL8cIfK45Q9s
         zv5fK0B3ynnd5malwKdVVHRk20at4vzf6o1SbN1Gt0uqsAyCrjRdOX/Rk0x7CBrPEjWu
         n9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9E7FSr4XBdRtkpi6//J5ZVQb2Hdd04S6xoUTabgDRWI=;
        b=z8XI9ziquLNPpDYrG+JBkNy1s8BuJD8+Gc/jvxkyhP91EXDIxDUYs9W/WaCKIE7Qq0
         eLVE2c9GB6JdZKE11KXaaidvsfcmEliIMfdKc/NRHqorKlI/jzs9xwojQeN28eXaG2ia
         Ndgdbu9H3pxN2IB/d5YKqp2zFGG9AQcsKjr+bfGZiygF0tDCdfgmbI18UtF+Eo0ts0U/
         wHYRIWCELes1dHaPKuHnqqJQKM8+tjTEi6GtKt0Y+la4fY+P0tcFLcW78+TLwDyi7q5q
         GC/5rJ7LLE02jdHHVzEcftw98k6+cq1/XdGz35sUWJorkAEtCGIU0K4mmyz9069aCnqP
         NqKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Don Hiatt <don.hiatt@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 123/183] IB/core: Map iWarp AH type to undefined in rdma_ah_find_type
Date: Wed, 25 Apr 2018 12:35:43 +0200
Message-Id: <20180425103247.376479953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714472718319057?=
X-GMAIL-MSGID: =?utf-8?q?1598714472718319057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Don Hiatt <don.hiatt@intel.com>


[ Upstream commit 87daac68f77a3e21a1113f816e6a7be0b38bdde8 ]

iWarp devices do not support the creation of address handles
so return AH_ATTR_TYPE_UNDEFINED for all iWarp devices.

While we are here reduce the size of port_num to u8 and add
a comment.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Reported-by: Parav Pandit <parav@mellanox.com>
CC: Sean Hefty <sean.hefty@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Don Hiatt <don.hiatt@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/rdma/ib_verbs.h |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -866,6 +866,7 @@ struct ib_mr_status {
 __attribute_const__ enum ib_rate mult_to_ib_rate(int mult);
 
 enum rdma_ah_attr_type {
+	RDMA_AH_ATTR_TYPE_UNDEFINED,
 	RDMA_AH_ATTR_TYPE_IB,
 	RDMA_AH_ATTR_TYPE_ROCE,
 	RDMA_AH_ATTR_TYPE_OPA,
@@ -3762,17 +3763,24 @@ static inline void rdma_ah_set_grh(struc
 	grh->traffic_class = traffic_class;
 }
 
-/*Get AH type */
+/**
+ * rdma_ah_find_type - Return address handle type.
+ *
+ * @dev: Device to be checked
+ * @port_num: Port number
+ */
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
-						       u32 port_num)
+						       u8 port_num)
 {
 	if (rdma_protocol_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
-	else if ((rdma_protocol_ib(dev, port_num)) &&
-		 (rdma_cap_opa_ah(dev, port_num)))
-		return RDMA_AH_ATTR_TYPE_OPA;
-	else
+	if (rdma_protocol_ib(dev, port_num)) {
+		if (rdma_cap_opa_ah(dev, port_num))
+			return RDMA_AH_ATTR_TYPE_OPA;
 		return RDMA_AH_ATTR_TYPE_IB;
+	}
+
+	return RDMA_AH_ATTR_TYPE_UNDEFINED;
 }
 
 /**
