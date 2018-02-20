Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519120405; cv=none;
        d=google.com; s=arc-20160816;
        b=bLdDxlUfsukAzYxArJMCxc2hMNVcMCQlCp/TF1V3WR6XLAzOmXXjbMvYIHqbbiEkG2
         O9i6yN61TWEmsL2kYHio7jbDzmLCJ7f658g7pk8TxqXeQqZJ/DbN7rghaH6phZYAC3Kk
         y7RRZzwShtsM8spiW5GKqPo2X/eJzVMtMrFzy2EAyw9/8wa+RzLAn4kdKzodwNKuNFHL
         8ZdGb8pMMCF6NG15QrPYlsTxLDBafOkiRhBfgZ4hhiz+4kkbs1sWX3B1LtSTgoURnhbg
         ntKTzySPsywjj5B1gPYn/2D7xzoZKV7NmwejJUBp2kM7hIbU5+s13ROyEINwxboUeI5X
         Ejkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=gZuhebZFRTWTInOvsJbnwWsVyOoWGqSYKElpKPft0dc=;
        b=mOjOzN82OfJxrbk8/A5wLP8FOx1w8pHRQO051oZnEvhAoa3vpzHzkcQMdPze9FfUZ0
         eQH1JaVjn7Spsb1zChS9zNh1D6OrgXP5DbMoMGHF+s9nBl8qHBWFM3uYC9IeFDU48iH2
         gcdCpelcM4TYFFJuqsZyTlH6LPLUi57SLhUJiPT/tGTZ9+7G3SLWL+WjAKgwPHKx+V2S
         +8YGhpTZu4+DfibbkoaoncnOiKHkNtdJzP+lP/It/knokrivf1ce04Xdo8+fIDjY+nby
         +9B06ZbwGXZHeCtXjMt9jj8m6/ScbVcbNuPUax8BaqpUZrbpjuKXZegOuC7B/UF5LcfD
         yqzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V5Djy2ii;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V5Djy2ii;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226KXPRIt9ClQZh7vV/ETfQ/Bil7OB2onZC4KhodYKV3bid2zAczF4F/Gy2pYDYPutN6zB7QBg==
Date: Tue, 20 Feb 2018 15:23:19 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] xen/blkback: update sysfs interface documentation
Message-ID: <20180220095319.GA29360@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592913198625691439?=
X-GMAIL-MSGID: =?utf-8?q?1592913198625691439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for statistic attribute ds_req - the number of
discarded requests.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/stable/sysfs-bus-xen-backend | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-xen-backend b/Documentation/ABI/stable/sysfs-bus-xen-backend
index 3d5951c8bf5f..20ef835785ec 100644
--- a/Documentation/ABI/stable/sysfs-bus-xen-backend
+++ b/Documentation/ABI/stable/sysfs-bus-xen-backend
@@ -73,3 +73,10 @@ KernelVersion:	3.0
 Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 Description:
                 Number of sectors written by the frontend.
+
+What:		/sys/bus/xen-backend/devices/vbd-*/statistics/ds_req
+Date:		October 2011
+KernelVersion:	3.1
+Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+Description:
+                Number of discard requests from the frontend.
-- 
2.16.1
