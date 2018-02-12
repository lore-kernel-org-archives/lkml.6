Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1572815-1518446139-2-16871700495127685187
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518446138; b=qm0US0gaqOtLh1hkk9DHVV+KGDbolJdlxd+GPkpzeaw1KMl
    Z/n+Qd/nQ3AzUP86RQRg0vExDsTYrBUC1LtAvQrJX6K4ZENjtdlLex1Bj4mPWFZG
    1xiq9zj1s+Xc7N21mfTaN5eqVIEtMlXuwNTGDNhXHXKvtd1s+XZaSPnOBVdOOnUE
    /nx42tRS4dst7EVS27jJhHyNU8uXjzTaEJp6FoW/DNOUzNG0A31RcSvy3jtMPucb
    5aYMEE1g7CFRb2jYkXzSelhiToSkGA+K0Rgq5ir/OGQqjYANzyeycc/3hTidpK7x
    3CRluyj9oMho8G+N8jgQmm4i+qE/GaWfQIuzmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518446138; bh=n
    C7HDhWJNZlof9fgsvKHR3O6w4LdIVa/DKzkq8kv+6M=; b=FaZtHgZn943+9dBV5
    AsTQiyjoX9Fk0xGjTtHalv0Otnne/s+vqM46wHV1G7YjqsF7H7LjH80M2iE6C6Qr
    /dNgwuGIOLLsD/aCVYIn+kGWWL35h+kJyW+FuBVctYr4ipd1UOeB0GDLKU91MjKe
    RKY7M50095vhP5JuB+DKqosZYcvoH3Lh53t9FGw5hnpQqxEfBx0nwpzVAXwhalNj
    77A/q8i00f2vgAlyF4i1a4SOg4z7kzSCiqQLP86U5l8E/i9z7SSvvAg8HCCrwp+5
    A+tyIU03RcZy3DxrMFsmfDaLv2+f/Y2XacjiUxqUmvstjXmUOikf7dHTEfDgKR3d
    bdvfQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rMrxUeFp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=faUAb2XF;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rMrxUeFp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=faUAb2XF;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224M5knrnvuSEDRrXQQZmcvNps9/SMY2WVkbFp5LhHTMjYXMHYZmd0bk7JqpJomLPYdegP6xGw==
Date: Mon, 12 Feb 2018 20:05:22 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212143522.GA12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180212125312.cjo76spuu6agjawc@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On Mon, Feb 12, 2018 at 03:53:12PM +0300, Dan Carpenter wrote:
> On Mon, Feb 12, 2018 at 05:24:57PM +0530, Himanshu Jha wrote:
> > Remove some unnecessary comments by giving appropriate name to macros.
> > Therefore, add _REG suffix for control registers. Also, align function
> > arguments to match open parentheses using tabs.
> > Group the control register and register field macros together.
> > 
> > Blank line before some returns improves code readability.
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> 
> The most obvious response is that this needs to be broken up into
> multiple patches.
> 
> I think I liked almost all the comments...

Please note that all the changes are suggested by Joanathan in his TODO
https://marc.info/?l=linux-iio&m=151775804702998&w=2
I think it far more commenting as compared to other drivers in the
mainline IIO drivers. I grouped all the relevant control registers
together at one place with suitable comment.
For eg:

+/* Data Output Register Definitions */

The macro names are identical to the names in the datasheet if you can
look and one could easily refer to the datasheet easily. Also, I
grouped the control registers and their fields together make it more readable.
For eg:

+#define ADIS16201_MSC_CTRL_REG                 0x34
+#define ADIS16201_MSC_CTRL_SELF_TEST_EN                BIT(8)
+#define ADIS16201_MSC_CTRL_DATA_RDY_EN         BIT(2)


> > -/* Output, power supply */
> > -#define ADIS16201_SUPPLY_OUT     0x02
> > +#define ADIS16201_SUPPLY_OUT_REG		0x02
> 
> To me it seems useful to know that we're talking about the power supply.

For that purpose I already grouped data output register definitions.

> Adding _REG to the name seems not terribly useful and it makes the name
> longer so we're going to run into the 80 character limit.  I just
> checked and this patch does add some checkpatch warnings.

_REG prefix is used to differentiate between registers addresses and the
fields in the register as pointed in the above MSC_CTRL_REG and
MSC_CTRL_SELF_TEST_EN.

Yes by doing this it triggered 2 I think 80 character warning. For eg:

	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),

But you know with 81 characters so I neglected it because it looked more
readable without breaking into lines IMHO.

> But aligning the arguments is fine, deleting unused macros is fine,
> adding blank lines is fine.
> 
> >  static int adis16201_probe(struct spi_device *spi)
> >  {
> > -	int ret;
> > -	struct adis *st;
> >  	struct iio_dev *indio_dev;
> > +	struct adis *st;
> > +	int ret;
> 
> Making this reverse Christmas tree is fine.  But these things should all
> be done in separate patches.

I am sometimes confused in dividing the patches. As per your advice I
should make separate patch for :

1. remove unnecessary comments.
2. add suitable suffix.
3. add tabs instead of space.
4. reverse christmas tree.

But these should be done when we have *more* instances.

For eg: 
I added a tab space in function static int adis16201_read_raw() argument
to match open parentheses in this patch. But I also added tabs while
removing and adding suitable suffix to the macros. So, should it also be
done in a separate patch ? Since there was only one instance of adding tabs
therefore I did it here without framing another patch for that purpose
while saving my time to plan 'what to include/exclude in the patch ?'

Also, given the above queries I was clueless as what to do first! Since
sometimes it happens that the patch series doesn't apply cleanly because
of incorrect ordering for framing the patches.

Thanks for taking your time to review the patch series.

-- 
Thanks
Himanshu Jha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
