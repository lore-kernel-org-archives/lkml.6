Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-487425-1520344419-2-15569433511565290688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520344419; b=Hh4MHvEZM0JS5++aQ5OHbVGvJh+Gs/rV9PLO6gTv1g0hRCq
    nYXDwKtfge0pKgt714fPiHCMAGC5ytjX2UmMpYlTtlWzKAwtkaQjPl86tJTjhPHa
    sIYI+ww2D0v1mn9Eubozh0jdN3uozuf2gcGP2VdizBmipDPNAeytCaZa++smjNlC
    B07OcZ0Ot/SW3sQXmPi95XDJ/MAxwM4/A2zXtg9hx6fkNLv+KzzEIhPF+FKRK8ga
    n+GTllJoPmPeREqgB0x/dnnwGHQZBt00Fyn+YWX+9ZJTLF3CzA1bYtKxxBDrMJ8E
    4KWiu89Szjg5kLmGyho8FyZ7kx0NmKRfOWxXvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520344419; bh=H
    TR1IRdzywBJbJMrObc76Tyijn5LcmgYZrqpaNXNBnM=; b=tWkceqwT1LvBvau0K
    6CvfowRKdhMzetwF0y89tsmywPJGpsNFa99uordPOBNtU8MrNl/ocaRl/wubdACq
    Dto26GQ6d8zDoAgcuW67xTimyfV2vrIgHSoXFIEOTOe9qxxrrMFgxzlcKUH/YRYK
    wVll52mO1Ce8ZXUgpWVev3hCbMK2b5movANItx3YMLdsDOjUo8+fbtBuD/Gqpro5
    OvhLOOCJaEpemHEx3HjgpuFCJ3E+XMILfgErP6GeaEET+VSlzOKp95AWId/8O60j
    ISaSp+qE7LDkFzyy0xJDVfCiLB79g8935AYPhjPXjyMut6ocAG9lGxuvFy7Ui/yd
    VNA4A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XJ9GYqsq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XJ9GYqsq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 6 Mar 2018 16:53:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <20180306135314.vxngtgj6yxomasm2@mwanda>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060157
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 09:26:07AM -0300, Rodrigo Siqueira wrote:
> @@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	st->trig = iio_trigger_alloc("%s-dev%d",
> -					spi_get_device_id(st->us)->name,
> +				     spi_get_device_id(st->us)->name,
>  					indio_dev->id);
                                        ^^^^^^^^^^^^^
The "indio_dev->id" needs to be aligned as well.

>  	if (!st->trig) {
>  		ret = -ENOMEM;

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
