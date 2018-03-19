Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2356021-1521449224-2-1108911403355959878
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
    t=1521449224; b=KBIt8gLA4VkD3tjaHkdzu+QgJ1w8wwEy5RuI1VfeX2E7dvW
    9QU3dM4/7HEtriqugxat6xTMcy9apuAA1rzdlwRhOG+gJ0VG40dG4q1p5nI/5dUY
    Y9l6lQE2QjVX9gzc9GWA3etpWPVmNwIE2J7d09DtEW2LDMZ0BODTzgmrJfP4/cJ7
    PgVqjYjpSyuyhwtUOOkHO5HA6vP6ovNDZ/AWUv0LptyXwLbCrIAmbn5m4iVxI9Xg
    +LGtIadttDeUyfgRJJ+wfraSwRn8321LQJQdDfGaawDFMCGMDxL09UgKFzH2sx0R
    diqQSjbV31CmvMA1M66Z3d19PQ6tAS98VEFuqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521449224; bh=d
    GlN8RMV5+HhHtDMSx8warWRb5ZZ26PYIJkGb2OV52g=; b=LaRFrZazjwG9oZ5H4
    s1mzNrwgcv9WkT9f8VHt60fjlfA0crTt3Vv4fY0Rv3O5MKMQgsEixV8OAnelsiI0
    SL0ekfs8HWqVlnkZZ5dsAzuHrdsC1LJMt6JQdhFRooMYlUy2nz+hT6j6C+yYHwNw
    GILWRJP6DRngLfy2T0OaV8Kor+j+HLo7AKVI9+bO60svmsTLZinLz/LB8T5D7G89
    5fU8pAdh7dX+jROO0VUJDHZPkJGVLvoKeaedy2KQ/kmgl56zijOB3Cy+caUIUASl
    fuRtlhTKBcSRAkkG6En1yjqG+HnQKp9FTTdFrIIueC/r5CHF6TlMxjlFGyxhNVns
    IRnWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=qdEoVOyV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpudeguddrudegiedrudduiedrvddtnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeejpdhhvghlohepfhhrrgigihhnuhhsrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeehfeejiecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=qdEoVOyV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepffgrnhcuvegrrhhpvghnthgvrhcuoegurghnrdgtrghrphgvnhhtvghrsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefjedpudeguddrudegiedrudduiedrvddtnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeejpdhhvghlohepfhhrrgigihhnuhhsrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeehfeejiecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 11:46:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Message-ID: <20180319084645.pruplfsgctqfs5wk@mwanda>
References: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836
 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=488
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
Cc: sthemmin@microsoft.com, linux-pci@vger.kernel.org, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks ok.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
