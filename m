Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2684992-1520537264-2-10590337379403498962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520537264; b=csG/oJZJpYUDqv0UBp6O3R3fDVFlFuFDblipKHuSz3EFjoC
    dxzEyJRPvTpQV05+jz6F9SB9eC/T0KG4XACrw8SBcnKJqFYrb/ki01EabpH6rGHB
    UJHK0UtbaKqHlwS0KU1dcdfJiSJavN7dKh3AFTZXroGLOnkmn0gn49pnmvRrJL5u
    hOpSG/RJb8GlkuaoaJj1QYl8Bbz/Vx+vUBKfVS3xYGBP4/w2XGcENhpVtPdiIAN8
    JFcymfUzdXv/oesZ2FGCQW+WkqJtFX1/Wn7Gp7Kst+951PXXXBDnyN/gpA+IJoXU
    u9+YJqKP+7uptsQQvQ59cBCmM4HSGm/VvtnXmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :subject:to:from:message-id:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520537264; bh=H
    y1y4V0r4RWu0JEUj+J9lU2axUyMF7vXHg2n/QcbyRs=; b=pcjV7UaVirL74wViw
    ClfAiGYWd5ZHnsT4B2G33DwCfIfWT7S8zK9wDLUx9WV0wTwZXUVYSgjdB7BWoimU
    dTaPMTl202eh0WwpkVLnda4P6chbl1WLU8/S0wa4bNZB7hW4JO4x2ufkPIXP2lun
    XA2WF9X3nNc/pKHQ91V8pTrjgTjHGhZp84hDzep+YBKjFFf1AKtxW2x8dDYc35aP
    R7Gnjb39BPbfmWkmz/YBRLN18SjRXLVpEI71TQABxaNxBwHLzlJYt9WpORdLRvWD
    3gx/amMcAXSfiJjfTk2yxJDkFxybltk4Ht4L/l5PQzz3pq6zU7Vi2s4mOApf+iSO
    tDPuA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DUjVpaW1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iUeKyVf+;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DUjVpaW1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iUeKyVf+;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELshLhTjUuKC0FYWgminAn1Hxe8eI8asLjnSfcG0qCxvh+dOn2b/n+1UFIAm17ZWVoVd4xA4HQ==
Date: Fri, 09 Mar 2018 00:57:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180308191111.GA2041@himanshu-Vostro-3559>
References: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com>
 <20180308191111.GA2041@himanshu-Vostro-3559>
MIME-Version: 1.0
Subject: Re: [PATCH v4] Staging: iio: adis16209: Change some macro names
To: Himanshu Jha <himanshujha199640@gmail.com>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
Message-ID: <6EF6C73A-ED18-4C5F-8368-929258026979@gmail.com>
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
 knaack.h@gmx.de, jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 9 March 2018 00:41:12 GMT+05:30, Himanshu Jha <himanshujha199640@gmail.com> wrote:
>On Thu, Mar 08, 2018 at 11:46:17PM +0530, Shreeya Patel wrote:
>> Make some of the macro names according to the names
>> given in the datasheet of the adis16209 driver and
>> have slight indentation in field definitions to make
>> them clearly different from the register addresses.
>> 
>> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
>> ---
>> 
>> Changes in v4
>>   -Have slight indentation in field definitions.
>> 
>>  drivers/staging/iio/accel/adis16209.c | 48
>+++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/accel/adis16209.c
>b/drivers/staging/iio/accel/adis16209.c
>> index eb5c878..19636e2 100644
>> --- a/drivers/staging/iio/accel/adis16209.c
>> +++ b/drivers/staging/iio/accel/adis16209.c
>> @@ -68,21 +68,21 @@
>>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>>  
>> -#define ADIS16209_STAT_REG			0x3C
>> -#define  ADIS16209_STAT_ALARM2			BIT(9)
>> -#define  ADIS16209_STAT_ALARM1			BIT(8)
>> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
>> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
>> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>> +#define ADIS16209_DIAG_STAT_REG			0x3C
>> +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
>> +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
>> +#define  ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
>> +#define  ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
>> +#define  ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
>
>#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT    2
>?
>It represents flash update fail bit! 

I think so that I have sent the wrong patch :(

This is totally the reverse of the change that I wanted to have. 
Maybe I messed up with this patch. 

Jonathan, please avoid this patch. 
I'll send the corrected one soon. 

Thanks 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
