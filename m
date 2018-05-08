Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3553578-1525819536-2-1094676162883310921
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525819536; b=VciLVkwQpiU7mnTje+h2XTRFTLUi8mLQX3LoqbXNQbfGxisj5R
    smnEsruuI2yMLGj5ZoWMYmFAYEDlOk458GxTAs+PUO59spwq0qdLJwDm0v7SGr5M
    9BFZr9hpLQpOG2laDMdBsXWyA3UCyoBuMNyuB545zdtxWIoTAo4DPIzLKdgIloFM
    ktLxbDyGOvw5qpmD25vOrgT57LoFueG/L5aehj3tD/xGxMGZep/lcvnQ1I8dRD/i
    VMUK8U2D2hl29Yy+hI/sEjJKHQjrEkL31z1BW3+XJz7GC10gZbd2sVUIjMa0aawz
    /yF80XbxIYKlwKIpwJemcuU2z0d0r8GvYoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525819536; bh=psAk3
    1trT22yldcl+MZxub5YqXUefxx+fN3Es2JF0AY=; b=gsdc+WiYb27Z/yC7URGOf
    +/yXCThDXdY2sin/YJ5UCvCbVl6ztGL5wO+GtFoTUa8kNIBIG62wKlaMeGq6NemP
    6yPblkpX2q5L0GtkNMsokhRyOLslM1EJJ1Jp/uScTnwgT9ic6U5AY89PsLNSRjwE
    cm5F+jTDW6YpSn1qgX0qYOCjPp3xXLBfLIvi0TOOoQU14HptVcV1ND522z44dYEE
    vMhBCKLPyHxG3xaYfu2mWCX9zsgUB2DmIwDyPPc5TzpfkbQkruyht7tzTqpfR4w+
    ZsFsYg69b2z8eD/a7/+nXYRH3sfEbdJigD0vo0kENWLtX+VAwZ0fUa8AZtcaL/hp
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=networkplumber-org.20150623.gappssmtp.com
    header.i=@networkplumber-org.20150623.gappssmtp.com header.b=Mdim0XyX
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KTT9+8BV;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=networkplumber.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=networkplumber-org.20150623.gappssmtp.com
      header.i=@networkplumber-org.20150623.gappssmtp.com header.b=Mdim0XyX
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KTT9+8BV;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=networkplumber.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIjSbfLYlRUTF7ee2ulf0E0plVPbDWPfE4fMXx8VSxutesiUJX9Gb76si+jUxJGzRk3n/0n6LR+MVyY8frK60zeT3//mF8s5uGuSBBIG3l2asfxbijuJ
    TSK3FHyfNunM/M4BE80scXzqos9fZL105jBTLims1zLb3L2r2CRVh0YH3EsPMGwMxgZ1Vu4KvaGgouanUEnOEO4wDwO1exAC4IiXoLcLooLTcrucq7pq+CHw
    FURcfYj0AAu7Plq17sgs0A==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=AC58djtIQlsaprTIuogA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpGpNf6kMDz6nOjdhI5Kz2Wfm+Ep6owYlgXlEUtGYfxF/tvFOpvxKuKOfeluPiTJcEixRS9Cw==
Date: Tue, 8 May 2018 15:45:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Message-ID: <20180508154525.37b6ddee@xeon-e3>
In-Reply-To: <KL1P15301MB00067B95F6D0B3D97387E315BF9A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB00067B95F6D0B3D97387E315BF9A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Jork Loeser <Jork.Loeser@microsoft.com>,
 "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "Michael
 Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018 22:26:21 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -63,6 +63,9 @@ static __u32 vmbus_get_next_version(__u32 current_version)
>  	case (VERSION_WIN10):
>  		return VERSION_WIN8_1;
>  
> +	case (VERSION_WIN10_V5):
> +		return VERSION_WIN10;
> +
>  	case (VERSION_WS2008):

In a future patch, we should get rid of the use of parenthesis on this switch
statement.  Lots of other cleanup of this code is possible as well.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
