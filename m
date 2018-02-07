Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2459548-1517963972-2-11865402613348230001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517963971; b=k/aGKr8aDn33L7PPSFL4tX5BY8tZT579ChYBR0vQ9zTEz75
    +DxqOYZwq88QgKrkwVkbaZrvRrOiVOUxGM8zIpZwFwTIW3wBkW+RGp5E1xijMYQs
    kTWHkPdIUM2d3f5BrdfTPoE8liW3NJ2uV6LYZ4bXclshKEhxBvO2aXOSf0om0oBR
    CRQ85d7zeEtudtGX4ahx7W5Qs5TKVExIEeBOfEVl5hYiav2N6fkmbzSQX2A/2P3S
    gQdP2wekNrLY7QderVpRznuhKJ4n+N/73yRe3gkxnp5ny2omjQyVaZzKE3z6x3L/
    U07YdDhZ84KT8VSa2k4oDblxljPaOiiXeJ5qFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:subject:from:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517963971; bh=i
    TsFD9we/LPWhJn8quvXM2U+H7nrm+cnYCzx06NMjGQ=; b=eABGRPflmNcAnXsk8
    hBQqdT9P2EzoOaiU/JGhcbrzypV0MyrhK/LQEj2dpHf88lYyM9mI5jdWbfAvs2JZ
    ftLWizofMkhs1hL27m570B2cOY5AeyqhFV6ePiRxE4KtXE+o3r1lYTWNhpj64yM3
    ShE3bx7IhLofQfQpd/J95pQ2KpLzP975CGWMajtatjwAdrvf4TfwKFlMouRwdd7r
    xk4GUun5DK/OTRwYaws1VEHrkeFrlziN5TTevGDTNKoSqNO84iTjP7VPdk+VKoWO
    SSDq8TNZaoEsgum6Je+UT4tGJA3aFJXQBUwON3j0OcQkxG70r+7c/80e2i+o6sRL
    99zeA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=avdh4Rcy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=avdh4Rcy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
To: "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH 1/1] scsi: storvsc: Spread interrupts when picking a
 channel for I/O requests
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1516831913-26013-1-git-send-email-mikelley@ntdev.microsoft.com>
Date: Tue, 06 Feb 2018 19:39:17 -0500
In-Reply-To: <1516831913-26013-1-git-send-email-mikelley@ntdev.microsoft.com>
 (Michael Kelley's message of "Wed, 24 Jan 2018 22:14:08 +0000")
Message-ID: <yq160793a6i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797
 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=603
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070006
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "JBottomley@odin.com" <JBottomley@odin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "longi@microsoft.com" <longi@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Michael,

> Update the algorithm in storvsc_do_io to look for a channel starting
> with the current CPU + 1 and wrap around (within the current NUMA
> node). This spreads VMbus interrupts more evenly across CPUs. Previous
> code always started with first CPU in the current NUMA node, skewing
> the interrupt load to that CPU.

Applied to 4.16/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
