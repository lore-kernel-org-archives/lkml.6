Return-Path: <martin.petersen@oracle.com>
X-Google-Smtp-Source: AIpwx4/4Q6adgAeCDNMwg54Ai/dqCPjU4Cldb0E+HT7y6p/QhOEOgWgvlDlwtRh28J+ekl3AGhtW
ARC-Seal: i=1; a=rsa-sha256; t=1523307442; cv=none;
        d=google.com; s=arc-20160816;
        b=G1Pv3ejmYyKttvEhtVsqi5Wb6CsZcClG+jagJzFtks+Vf7sBgvvTVq1eeIzFEZXWRc
         kpAYTymYEMWUFsm9Q4mD2xXBjRz+Jk0VW8Bqxwi6k9KvCz+ektFNL7Vi0DacxGwoIu5K
         wdG1E/hL4mvP672zc6xASPSwslVBV3cdUpK5VAUHf2XtqOfSmTVO7cYw+gsNrDB1WeU1
         lWs3ebOUQBNNT4FGkNRbKagZPxCRLCEEF9lgkL6Drih16Ho1iMAn+btMysOAvA2NqgUD
         tNztKLO0Sxj561NEpecRagJxXrv7Jx2EUOvfUegEmCC0W+SMjBVnhJmBXNF//6C0XsvN
         8WIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature
         :arc-authentication-results;
        bh=9H787Nww4LiHW9voLDLg/l7xC8OJ4OowK05/wHprJyo=;
        b=YZvP5YPef1bF1Bo1YyZkZ+0XKqXCI18o6YdzwutgOy4xWUdbYN3Mr6oeHuv7NtjqOR
         FWY7j5TxRWSnWNNf6JJxhzRvfE3rkEVoyynawEWwVdNjnSVijXB5NnykmAjY5nG9fbu5
         IuMsCrLcnVT2/+Dugoc7XvsDHdyn/6v7KQxfhS120j41OzangT+w/v9zJGMyuwaAiNlu
         YHf7rBGFxWTrq6teI92bLkNLhdHTyiUFiq0Z+aTo55dl6deDi9agHoYGmHU3t6q4VDdw
         6wN+rLQ84a4oTJxlNQbJyJr826nh3EyMLPtBglin7tJusu+XlvoVkNq5mo8MT36KWTEG
         P32Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=bvL42Wjt;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=bvL42Wjt;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Smith-Denny <osmithde@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging: fnic2 add initialization
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
	<20180405211644.GB12584@osmithde-lnx.cisco.com>
	<20180406050752.GC27591@kroah.com>
	<20180406220010.GA23478@osmithde-lnx.cisco.com>
	<20180407060901.GA18744@kroah.com>
Date: Mon, 09 Apr 2018 16:57:16 -0400
In-Reply-To: <20180407060901.GA18744@kroah.com> (Greg Kroah-Hartman's message
	of "Sat, 7 Apr 2018 08:09:01 +0200")
Message-ID: <yq1r2no3xoz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=604
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804090210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942284542554315?=
X-GMAIL-MSGID: =?utf-8?q?1597303624911095263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Greg,

>> If you think that this driver doesn't belong in the drivers/staging
>> community, we are happy to explore getting the driver fully ready on
>> our side and getting it into the "proper" place.
>
> I'll take anything in staging as long as it has the correct license and
> builds, that's not an issue :)  But I do want to get agreement from the
> SCSI maintainers that this is ok to have in this part of the kernel as
> sometimes it can cause merge issues if there are core api changes.

This is the first I hear of fnic2.

My initial questions are: Why is a new driver necessary? Why can't the
existing fnic driver be extended? And if it can't, what can be shared
between the two drivers?

A good place to have that discussion would be on linux-scsi...

-- 
Martin K. Petersen	Oracle Linux Engineering
