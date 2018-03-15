Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-512551-1521127423-2-6813225729504055582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521127423; b=rYpe7F4egZJXn4h9KucXnMm9RR3d7KOEUXLFUdgVL3HPyw/
    b821EsDdNXwJwZ7gwaYGg4B4uzJN6Yg/8dgnop72Qr0PYuyzsbPCiPiFNIefrHrg
    zjdz4iDwsX82qZYeLZIOPZnDZd1LaKnAcpy8kaHc65L3AttustPQRWCwTKk4wKuP
    nzdt0GPITwp3nWRLP5re8+TgKf25KGj04tZbEY8duTso5PKZe+N+TPoRXKlg7BSe
    DcCdoDnz4oYZ5zpcw0+Nj2kGA30UpvYIaA/gfxAYHzeu062gJ8euYBK2V4lUbyk6
    DhaLH48yQOFTAbRyqyzjydkeJ+OEKCNgN8dY8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521127423; bh=i
    lBosMbfzpGoKlhwRlqlMCRnPoPwTULYQLX4NjHhphg=; b=i4R8y9GuYrn78QAT3
    vBNBHhb5UV89LQ3ucE8uNeRB6i9Df9ajKpMasQrVGSfqwTEPIUTqA2Ln1LY2UAdq
    zT13B80dNCQATrVTjhHjUp7PReRRh+95dTRcY/G00hz2SscxXuDY1zwLlmrL/w3E
    Lc8XrGUl2Kzaeft1up4+MajXFyZhrP0FPqSl1y93Wd9/4RRYKbLPCY6ruy+flR4R
    kX5ANA2h+CHGoTfWDy7a3OFk9gcHEyP3JnfQtJCePWFb3PBIt9WO1XK+b/4xF3AS
    FPHN/LSuarRnBNJ8K6u5Ei6shSp/td5TgkWNVkwMJCqgT+TlemKYUKJ/9NO21HGr
    9BUiA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=pcu4HwcB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=pcu4HwcB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 13:56:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Andrew Lunn <andrew@lunn.ch>, laurentiu.tudor@nxp.com, stuyoder@gmail.com
Subject: Re: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Message-ID: <20180315105642.szn2zhrsgwsv35yf@mwanda>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
 <20180314234437.GD16379@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314234437.GD16379@lunn.ch>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 alexandru.marginean@nxp.com, agraf@suse.de, linux-kernel@vger.kernel.org,
 Razvan Stefanescu <razvan.stefanescu@nxp.com>, ioana.ciornei@nxp.com,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:44:37AM +0100, Andrew Lunn wrote:
> On Wed, Mar 14, 2018 at 10:55:52AM -0500, Razvan Stefanescu wrote:
> > This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
> > with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
> > switch objects discovered on the fsl-mc bus. A description of the driver
> > can be found in the associated README file.
> 
> Hi Greg
> 
> This code has much better quality than the usual stuff in staging. I
> see no reason not to merge it. 

Yeah.  It seems pretty decent.  Stuart, Laurentiu, care to comment?

Meanwhile, netdev and DaveM aren't even on the CC list and they're the
ones to ultimately decide.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
