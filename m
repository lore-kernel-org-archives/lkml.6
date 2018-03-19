Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2220729-1521443709-2-13933862262829909446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
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
    t=1521443708; b=RXVIRT7Br4raBoIWrhYqCkgcf3bsg9s4P/wMva7y2Zuw1ze
    AfSWp6WKSHFjYZm1ud2oylHTXsZwl/j3aD9jnxtt7FKp+FiCz1sgF7yHyyYt0pRr
    Lwzj9aAl+T7YhRLrcdk7HNP7Ax8FsHSaO4xnHygOIoWpoOFbKdgc+ixn5Ah/5xSi
    v1uJvXglICFJ76SCg1kWOUGs4hvinTrUYtFHdYac9wJVo+54DGd1GFVcauvlJIOu
    odi4fRKH8c+oUyQc97zLJ08W+mgVveDjjkiOLHi/bq8shb0wX3yjyS/FQ2rg2bVJ
    PSvfOZEWxiPVE0flGMaYnq9N8IvVNyZEjkNvr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521443708; bh=u
    d6bF3IqzSWy1ZL1al4Hek7+mXp/k4HNCyGu7UyCrT0=; b=Rn1Z2VIyt0SSJbbaV
    WmQJQIbhCDdNWGd6wLMEgy4QvmUAE/jUbgUzNIWS+plY3L8GENP0MA7IJ7SY0Pn7
    Fb1e/uhaqNLkAsi7mLBgTPUU24i9kDuTw0YqL3uUz04RwaGBybeaBabPOcn9qIvw
    NhJjj9FXHZtezohAyrx81AWjaritFyemnhnFva+ukNR5wKCDB429/FrI7UBRQCpK
    dWMYwHIHCCZPFemd5eMmFZ5aOEbQZmA6R/eKawID3QRwIhmEWYscZ3hX11rhbfgG
    R0urf4/jUqbcUFAs4Dun2R4N7cj7Dxku415lNII8cWyjwowi/G34Ma2VV3o7faag
    NW/xg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=QmxvqP+4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudeguddrudegiedrudduiedruddvnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeekpdhhvghlohepfihhihhtvggrlhguvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeigeeiudcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=QmxvqP+4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudeguddrudegiedrudduiedruddvnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeekpdhhvghlohepfihhihhtvggrlhguvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeigeeiudcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 10:14:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: Re: [PATCH] staging: media: davinci_vpfe: add error handling on
 kmalloc failure
Message-ID: <20180319071435.svpg72uomxfc6hoj@mwanda>
References: <CGME20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee@epcas2p3.samsung.com>
 <1521176303-17546-1-git-send-email-ji_hun.kim@samsung.com>
 <20180316083234.yq7a4rx6w35amflu@mwanda>
 <20180319042457.GB2915@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180319042457.GB2915@ubuntu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=732
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190007
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 arvind.yadav.cs@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 01:24:57PM +0900, Ji-Hun Kim wrote:
> >   1294                          } else if (to && !from && size) {
> >   1295                                  rval = module_if->set(ipipe, NULL);
> >   1296                                  if (rval)
> >   1297                                          goto error;
> > 
> > And here again goto free_params.
> > 
> >   1298                          }
> >   1299                          kfree(params);
> >   1300                  }
> >   1301          }
> >   1302  error:
> >   1303          return rval;
> > 
> > 
> > Change this to:
> > 
> > 	return 0;
> Instead of returning rval, returning 0 would be fine? It looks that should
> return rval in normal case.
> 

In the proposed code, the errors all do a return or a goto so "rval"
would be zero here.  Then the error path would look like:

err_free_params:
	kfree(params);
	return rval;
}

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
