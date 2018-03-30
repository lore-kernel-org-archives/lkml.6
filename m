Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3271353-1522409570-2-3316568416508756070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522409569; b=bL9i2F3vbzJaiGnF910pZcwtiaWOdE8up2XgxkVDofPOcNNXxS
    13yTpTnZgUMlXq0VKSmJW88mgu0CnQGl0Qf+nA+88Q8871vCT45jbnoHEdeuQfut
    N0xkGdkZtVxxv03WFJM8Ip/bsblApRliTHiCJ/i5Hh6lqegrws1POBnwe9yeSgXm
    jsm/zb/43jl93/aomYxBIPad1PRvJLgAYCd7b1NpmUEx796PHcBrmHOmBxTJu2fj
    EwdEb11PE+B89n3ZkGCIU6oJdCAurtofAUj23qRnxjZP/1ANAOnXzkU8w0dRKNDF
    mMjn2HyvYChNb6r1T6gphAJ7nkRtqge2rFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522409569; bh=XX33T
    nAotn2BE3aUKK8o3++0RLAVYrL77tQK54oW2DY=; b=KG75ZPEoIqRlIN6qzhdsJ
    xihhyCOuaNapWrIe8Zr+mpi4/ERuySwgYNB3ZaUxnvFa6VZ+h1z0oTYnnEiutEu3
    hEA+TcTRQWNOrq3uCCrZhH53dzvf3n6VLgjV5kDCloCMErs9BDptuc1vRfoU1ipG
    wOMP8xkaqE72ThPEdX44GOuTlk8B6H9+PLfkEvWpAmteLdUN0DDea+j1N1VNSmjT
    VVnu7fAb9z3dq8+05psE8unr0yd+z2YTJ8tJ5LPdXGlNDp8VrbuiDmZ2mh/KCoxj
    Tk6QLnDtfqIYSoq9SoBGLwk8gGzfBLC5sYJwt4tAfzy0TaDVtw9ZULPDuoi99fvk
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE01OoQrvzroVma6Ij7vLaTuaJv4paBmV0Gv177Af+At6Rca+K/V3ipNgFWjVw5rvw8WPKmyYgX9iD/u32Dt/qWj5q7dk2fnKQmqig+qQGKDUr+jRBOa
    fDkMPvpHnpMCyh5LOanjzU5a9M2YtVcnw3kTnmFQKdr4K0EudrxDKcyqA+2UU3JmIRHyoSjR4lsO61dxtaaIuUbVB769jHYiI4lgA714hCrXVXgZfYiYWv2Y
    qAGyqSkomMB8YkrObAuUjA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=pDPisW7ChS18tyXcb1sA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97582175B
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 12:32:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v6 2/6] Staging: iio: adis16209: Prefer reverse
 christmas tree ordering
Message-ID: <20180330123238.51d9b2a5@archlinux>
In-Reply-To: <3f021293e6183f6fefb597a9a01b762b73d69bc3.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
 <3f021293e6183f6fefb597a9a01b762b73d69bc3.1522306893.git.shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:43:23 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Prefer reverse christmas tree ordering of declarations to
> improve readability.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 0e6366a..8f4fa6b 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -270,9 +270,9 @@ static const struct adis_data adis16209_data = {
>  
>  static int adis16209_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
