Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1362587-1518440015-2-9140768162185266238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
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
    t=1518440015; b=sMTl5FEbjQQnGxmsx2Rq3jHUC9WK6zuHpBlGAhsn2s0Cphb
    5Loj1P+5TsbtnzojkveGsI1Rv73gcmzKlhPGzivpSGpCbEM8FST2sNzdh/T3Bh38
    mrJz6Jf/yNyffuKEYl1Dl21zngfL2f3wrd8ZR+BFCk8ZEDtquXebgc9KUz3izDsQ
    +0wPKLO82eWFy/8218FmI9vA/PZ1Rm37d0p3bpbqdJqgR4N7QTNiIJJSw0tIhhdv
    jZ0KABHgaw9TaOT8EZ8h/ZtoiVL/0dM7ODbV7NsG6Ph4WZ0Yte/GyRhEO/EB22/p
    iKY3KfpMUkoR6ZdcsUWDQRTEuvceYmi5LewEKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518440015; bh=F
    1AHbKr81wqd3B4s6XKGyTj9RsUqDsh1CAdBZcVQpaI=; b=wv4M7xoeTtiWlcqFf
    lRikWFzIfCUgP5O/YK0qB44m5Qh37ihQJhkQIbyBCG7HeUa1W6C7Kcnjsz08EG3C
    LAITfa7FesMWsAqxQ/qSyzc0T2juMSmSM1ODzBvfExZTr0UGKEhBbVhWN2IrT8lD
    bPhuzGB3rtR8DQMrl9kKLocOAjjJ5pM7oHu4KkX5ilUmMPQidRkMpqH1cvsGG3W7
    6+iGYOztY1zyEcPYLtKG+9YaIpfd1K1Ypc4qVrb1icK+O9CrQlh9tZQexboEbHWf
    NwH0BdPune1DsNfKOvdt9/AawMsxyV7F4R0TD7mxvttiBMs0p6o98XWX3NihM6I9
    OBEFA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BrFz2Yiy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BrFz2Yiy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 15:53:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212125312.cjo76spuu6agjawc@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120167
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

On Mon, Feb 12, 2018 at 05:24:57PM +0530, Himanshu Jha wrote:
> Remove some unnecessary comments by giving appropriate name to macros.
> Therefore, add _REG suffix for control registers. Also, align function
> arguments to match open parentheses using tabs.
> Group the control register and register field macros together.
> 
> Blank line before some returns improves code readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

The most obvious response is that this needs to be broken up into
multiple patches.

I think I liked almost all the comments...

> -/* Output, power supply */
> -#define ADIS16201_SUPPLY_OUT     0x02
> +#define ADIS16201_SUPPLY_OUT_REG		0x02

To me it seems useful to know that we're talking about the power supply.

Adding _REG to the name seems not terribly useful and it makes the name
longer so we're going to run into the 80 character limit.  I just
checked and this patch does add some checkpatch warnings.

But aligning the arguments is fine, deleting unused macros is fine,
adding blank lines is fine.

>  static int adis16201_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;

Making this reverse Christmas tree is fine.  But these things should all
be done in separate patches.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
