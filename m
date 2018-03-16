Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521196629-2-8404052001677848257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521196629; b=Vtk8/jLq4GXmlHf8Tq9Qkk0X9POgpcDSi9v7j1aRt/O/P8S
    MbydLgTV8CTZoG7DHpl9hkCE2cf+1w+rCz0+Yff5rRdxumVoJZeUOdc6bVt1v0uR
    x74/kwIIg3hV9dnL1No09ma7O1DfJs8qhRniP1/xr7u3v33wRsVuO+SnrUxhTVED
    fFz+6hAsDEkEZmakVCdyP14vJrVk4bOB99uWzPchPDOybl8ZbTOBG9WvvgW1rDjl
    94dRMI71EvaDOdpVsxgS4SW5Gyxv24Am5+UlWAWwYT9FX5Dv4Sl6ZcgqZsichkRE
    ggtD7j34e0Oh9IlWWISlBPav+jVNpE5nK/4Pk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521196629; bh=S
    QJfSfZG6Mar+8mqRdb5gCIm5SxZStjeGoXIqCUTnh8=; b=HDpsV6rGWBT3KFvSd
    Oj5gmLoDEPbADQ0fFF97aYfv9cpFbEQ3F4bPEJVXPx0MfrQBbgKTl48QTpt75T88
    qz0ngB2dSSGpRaeRio3Q3mX1j8vIImHb6/xkD6V8yazcFi2PNOrvvpQK4Jqu02B4
    XEhBxULtKe93MXj1ECFIqz+uKrPGkZ/r+rt0GTYpjmJbtn2yyUSYjos07vIaD8mv
    0MlEIgDrUqahelaWq6HmHdSC31nRkyfl3Cu5Ce1U1dTuwkL5eJot5jsWCj+E7QGA
    A8teFEs7dT2ydWtYJXryRl7giNvDVF4LeymeG7Mlrl4EcuLFIF9+TZBdGY39J1Ij
    JX1nA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=UxjZG2Sw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=UxjZG2Sw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 13:36:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
Message-ID: <20180316103652.jparuok7dsmvu5xp@mwanda>
References: <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315185943.18902-1-pratik.jain0509@gmail.com>
 <2dd4e733-b74a-c296-a554-3520a85e8ce2@mev.co.uk>
 <20180316102931.GA28344@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180316102931.GA28344@archlinux>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=705
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
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
Cc: devel@driverdev.osuosl.org, Ian Abbott <abbotti@mev.co.uk>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 03:59:31PM +0530, Pratik Jain wrote:
> Yes that can be done. But isn't 80 column limit more of a
> historical convention?
> 

No.  It's not.  We're not super strict about it but it's still a rule we
apply unless it hurts readability.

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
