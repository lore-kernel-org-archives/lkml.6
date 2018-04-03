Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2283497-1522786243-2-4976202338288825447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522786242; b=PAoiHz/q3THquQmHIJQl4XPHQc6wgOgjSnX/h3zaoQc+KS7qU2
    b/ckTN/fPxqh86qBMqmWjzidpfr3jyzpvtNTJqaFoBb79yHgudK9caWU8ioAir83
    rxlEHyS09/FjCq6uLCgUOR7PN7wkcjH+HsAVcqUlPl8Ah3+QKjDpLSxDaBwttC3k
    Kc2yGG0Dk6+q2BQisi45dPkoWSluEr2jhkSvS7BbPSUuwMDvq2P6Ygg3NLjWh/4G
    PzWfF3bHJpyO5EFV/4VXPbesGCx7huuhiLNhQE6DXfJnAUA0N5c4nr6vJZevjR7m
    I1UDjs7ieDpxCMoX+v2I/vFSlOUkZauubRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522786242; bh=ldNTR
    A66wDxdKcgQWuUqzN6410I41CWtLWQE4IQtyxc=; b=XHEB+cgcOQLt4drvWsy0D
    sDVy0TXH2JROrAna8/GBfjlcNW7nPNLYWuM5DX8nw1OWFlgY24I6yp0zjMZ3LanZ
    gbwf4VBwsMWRMWXQmE+2U6TFQrixCna+T/t/IQWcNiiwm+nFXwxYsVL9mDbihlBb
    FD44QI3hSoNcasgLD09F6hGIqssOOiu6S2PhGkvr0dVkC+cdDucuWEA7qewzQXMq
    33vLnFAmn93OJv4m1j0dotTM6V/zhIdPnlyBBulDE9CjOfK7pnRN9aHKPqKemUEt
    ZscwJhSKbV6mMSRZ/j7NF0s3K8Z9blGKRUeG+yMqApN1xR1jpAcmyF9hSFzbhXdV
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMS0zD4Q8KA62M8+UVVNSRMqHxclnj0nugSMrZg0Z7tinsQ8szhTxVk0XncF9Uc6wtVo6U7OoNI0V7uwznRyd/SWZZX+qJ3YrwJ/N5nuYJYry28lnPEB
    UPHKsVUHlHEu/VCqw3EHznZQuZlANcVqf35wkBDTixZhT+LKW+pnLhNKs43kC2G+gnr/qUWR/c7jj2JpeEhxPgNypb2ummCYT+pi8SiiJuUZjhewqr/wiJoO
    fYtXq1TpJD9uzVW3LUvRWg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=cUvWAgw9dVRJ0HisxHQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 3 Apr 2018 22:09:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mikelley@microsoft.com
Subject: Re: [PATCH char-misc 1/1] x86/hyperv: Add interrupt handler
 annotations
Message-ID: <20180403200931.GB18939@kroah.com>
References: <1522785455-1445-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522785455-1445-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: olaf@aepfle.de, sthemmin@microsoft.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, marcelo.cerri@canonical.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 leann.ogasawara@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 12:57:35PM -0700, Michael Kelley wrote:
> Add standard interrupt handler annotations to
> hyperv_vector_handler().
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Does not match the From: line :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
