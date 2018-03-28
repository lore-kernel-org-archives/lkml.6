Return-Path: <martin.petersen@oracle.com>
X-Google-Smtp-Source: AIpwx4/vhR75n8Prll3p3r72mB+HwEeF7Q5iIlvPKV8z5z1ERleCZvdqbZaE1UB9Pb7ZpfmTAk0u
ARC-Seal: i=1; a=rsa-sha256; t=1522274639; cv=none;
        d=google.com; s=arc-20160816;
        b=Mw8F2shQIRzELZZY/fejI2FqH4h6kzR1pk3Im6amYd5O8/sVl1GTrxAd9ViZuwsB8e
         5DowkQjwCRmZFLgCU+NSsMOHX0QT5X7Cekctprc+6nWMfPaGovaPh6gi+LRY0OVgd2qt
         3Z004IrdawgOAdJ8tgfhYDQqIGYcFr1zSMDoi75i2yBy3a0tIJzZ5MXpvYuAl+n0ECEa
         Y/LnrjbgZCnhfyWerNtmkG8ejXF8pzG3LhyfrxhzNRQYzDqjeYALHLjT4PgqLjgRWjMe
         YuYj9DedkXWZA5RpymIDeR1Xg7TU8qP1MSy3kMc+5mjwzlCcBpabaUmmmJA/gM16FAZu
         WS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature
         :arc-authentication-results;
        bh=R/JOQ+jzq/8RyFuOPs5AxgR4w/H1dyqRIpNRjhCia5s=;
        b=QVhUrnxJL9hJi9YGo1k05N907sCe1uJOQbcwP/tLE12zULUGvo1dHTFj6lOO6Wzw+8
         Db0alqU+KSu894ITx+g5nXmp7/8n0s7ZJ3gj58Kkpk6fJJOsqC6FhDUT285ZtwGUhY74
         bKR3K+tNoifGL4rBB3HKobT3WsS9pmMfx8fq9B/HXoQaGAk8JX+YauR7EQuzftqy5wAw
         +WjUwxQWaiKcUDtnKFlQXIOIXmAgjcIS7Gof7Grnwq2BJTB0BTEMSEIvXx4/nAgvKdEq
         BtvvzAwM2EqVtZyWR5j8G8EPubaqKt+Y5Mp7HMYPvg8akjvUjitGOIS+purLB/BUIx9P
         B0ig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qiopzlGT;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qiopzlGT;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
To: Ohad Sharabi <ohad.sharabi@sandisk.com>
Cc: stanislav.nijnikov@wdc.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, gregkh@linuxfoundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.lemberg@wdc.com
Subject: Re: [PATCH v3] scsi: ufs: add trace event for ufs upiu
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1522230138-27674-1-git-send-email-ohad.sharabi@sandisk.com>
Date: Wed, 28 Mar 2018 18:03:28 -0400
In-Reply-To: <1522230138-27674-1-git-send-email-ohad.sharabi@sandisk.com>
	(Ohad Sharabi's message of "Wed, 28 Mar 2018 12:42:18 +0300")
Message-ID: <yq1tvszhn7z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=383
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596174003792567298?=
X-GMAIL-MSGID: =?utf-8?q?1596220651761832910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Ohad,

> Add UFS Protocol Information Units(upiu) trace events for ufs driver,
> used to trace various ufs transaction types- command, task-management
> and device management.  The trace-point format is generic and can be
> easily adapted to trace other upius if needed.  Currently tracing ufs
> transaction of type 'device management', which this patch introduce,
> cannot be obtained from any other trace.  Device management
> transactions are used for communication with the device such as
> reading and writing descriptor or attributes etc.

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
