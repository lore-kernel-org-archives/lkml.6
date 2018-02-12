Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1541957-1518446806-2-10265537349217734673
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
    t=1518446806; b=Fn3DwyMs5ME1gctdP/i/DNK5VcujQbD1mU4rbm1SWvYQiUk
    MGUjUwn3LtDYILu0OUoBvkW5JeTzH9uhUn8MF1tPZI1lHQBHh3WCcGJbIh9JrcIf
    pGCdNkLXagmHr9/egseTFKCUlLSFo1Phtr4N6IEo/lXS5s1dI/fEfhgfKy/PjNww
    Ui6pIGdHiDDmStiKkUSvYFC1sRGb9VcJyIGtuY3ou224gTZvPaIBRh8d8bbXoYc9
    789gyYzhr4RzlRjXTmKOJBONl+HCuroG5gSxqlF7qn5htIPX7EfallghTD8kgw65
    K0OZTqFF9vHbZ0iqQR71v5H2HgR3xSyMdaaHc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518446806; bh=L
    /aghXk6Vb4MOxJbn6f4ya9LyIaiOuAeRgQ7jRZJNfk=; b=MdBlGfMC/wZOTod0n
    wuprVJgZQJZEZkAykWYCEFaGTelJy2Ey5VW1nFMmKW8x9ZZzr8nq1oqVD6oaG7Wg
    Dtpm5v3F7IKfyYKh9bFfBp1h2N3cPi2GsxYYhJDRDDfeNcXSLJeOXki0fdvHlW7K
    HO7+zWQuagsaZziw8Bd3QYMrotlzLnUpWK9qB3ZG1PRuTB03Gt4rAb4WtAPaV65M
    nPRvh9xPOpAu6oLHI6/v5kZdD+RN5uNPS52JT38rUv5ImOCauTPS1a2N8oAJcAMX
    EacLPEcpf4VGXQgyzqz2EC2Y4CpB89KeoY1rUKuoOhI5Gmx3Pp4VzhybbM3ELyTk
    6eAzQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VUbYAS7C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VUbYAS7C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 17:45:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212144542.qievoq76rvjigwm4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <20180212131826.ebazvmp6iv7i5fav@mwanda>
 <20180212144157.GC12142@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180212144157.GC12142@himanshu-Vostro-3559>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120190
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

On Mon, Feb 12, 2018 at 08:11:57PM +0530, Himanshu Jha wrote:
> On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:
> > I think -M is prefered for these types of diffs?  Not sure.
> 
> I wrote about that in the cover letter if you missed. :)
> 

Yeah.  I seldom read cover letters.

> > > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > > +	if (ret)
> > > +		return ret;
> > 
> > We should clean up the IRQ which we enabled in adis_init() instead of
> > returning directly.
> 
> I'm not sure about how to do that.
> 

I believe in you that you can figure it out.  :)

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
