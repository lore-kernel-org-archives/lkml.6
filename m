Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525487247-2-17750050991440333012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525487246; b=ZhNAujscdC+5W+6mAiHTEaegOXMIpuhY15TeibSXV3vVOpURFL
    Xvde1MOrqhmpuC82bf/X/bZzixjZjVeKfl5fyOMr5uHncA4Y/fG5kwGR2keDsrsw
    ZUvoBGIdaFWycSv821wS1wHzmFUOsL6dnRJWbMQPLx1Ho2yeJYcboBSwAvs52wD2
    7fkx2U98w+rejcu8M+zN/VLOmhU3wKb7ymmM+n7SmWHND5QAiZ3q0nnfIi2Ex4iF
    mnlrjT6JTBVKPQK82YA5Wb9mbbAVx33yFz9NWhlkOrIque1lFuJlmo78dXgFXhaB
    0nfko3Ss5y+YIuIiyDC/LwfoeZ5FznjSckRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525487246; bh=wg68+a2waf69678+r7yO/6u6xodzXi
    53OhucmMByA1g=; b=dMKTNpohJw+RNAlKGGER02kR7LxkSTNOdDs57NX6PNwWfY
    gOz7lj1lWk7gcxm25aLy9Emybkrq9EOw2h1Wp52k3JUZAH5jsKx/z+gbQ0wola0F
    cPuWtVwe3VDLIfPzAa8RtA+vedHdfZY47qPJ/iobVyJhGaX3Zm8PAYp8qU/rNOZB
    R+vNv51RXdBpcbHmf8qqU73gIAKBiwN9e+w9miwePUqbFxW8vRFFXohAlNFCeHBz
    QqmUDHRqOPHu3UaY9PQdBEE99fpvkX0fTBx4dSHZwk/0hQ/kCvoUPRGT47gA9c4s
    OKU8EFv6yqNKdmEU83b3weDuIanUR49Qt35ck9qA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ItZ+Qpzx x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ItZ+Qpzx x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJjVV/fS99YFxrmNCe792cE7R/ueomCl2CE6LdmAIVq3SCHnZeDOubsmK/6KsFDJ3Xkjgl2Wbo8IbLWNTFAIga+m9FBNv+622+ZnV+0sfiyJy4XGwEzJ
    d7nmWXhH0Jkc1QWry96Vh3uNtE5TL6tK/3gkHedehoujcictkYiji+R1ZpdKJbf8euJcjI+iOpGRHG/HYixHopJzYwO3J9QzSdX0VJ/Z1s/vnZbDv8tttYmf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QX4gbG5DAAAA:8 a=cm27Pg_UAAAA:8 a=B-4895p5AAAA:8 a=QyXUC8HyAAAA:8
    a=yPCof4ZbAAAA:8 a=_9Ko5kwRwqt1M3ZB0jcA:9 a=CjuIK1q_8ugA:10
    a=AbAUZ8qAyYyZVLSsDulk:22 a=xmb-EsYY8bH0VWELuYED:22 a=CvvKU93EpHcLr5xCDv7z:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeEEC1Z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEEC1Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 22:27:24 -0400
Date: Fri, 4 May 2018 19:27:13 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Marcel Selhorst <tpmdd@selhorst.net>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tpm: do not suspend/resume if power stays on
Message-ID: <20180505022713.GA29590@kroah.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
 <20180502143830.3534-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502143830.3534-2-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:38:28PM +0300, Jarkko Sakkinen wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream
> 
> The suspend/resume behavior of the TPM can be controlled by setting
> "powered-while-suspended" in the DTS. This is useful for the cases
> when hardware does not power-off the TPM.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: James Morris <james.l.morris@oracle.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 3 +++
>  drivers/char/tpm/tpm.h           | 2 ++
>  drivers/char/tpm/tpm_of.c        | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 830d7e30e508..5463b649bdf1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -969,6 +969,9 @@ int tpm_pm_suspend(struct device *dev)
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> +	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> +		return 0;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		tpm2_shutdown(chip, TPM2_SU_STATE);
>  		return 0;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index aa4299cf7e5a..41756a9e9ad8 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -143,6 +143,8 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_TPM2		= BIT(1),
>  	TPM_CHIP_FLAG_IRQ		= BIT(2),
>  	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
> +	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
> +	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
>  };
>  
>  struct tpm_chip {
> diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
> index 570f30c5c5f4..669f4a046398 100644
> --- a/drivers/char/tpm/tpm_of.c
> +++ b/drivers/char/tpm/tpm_of.c
> @@ -37,6 +37,9 @@ int read_log(struct tpm_bios_log *log)
>  		return -ENODEV;
>  	}
>  
> +	if (of_property_read_bool(np, "powered-while-suspended"))
> +		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
> +

This last line here blows up the build, there is no chip variable
defined in this function :(

So I have to drop both of these patches, from both 4.4.y and 4.9.y
queues right now.  Can you fix this up and resend them?

thanks,

greg k-h
