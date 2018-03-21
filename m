Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521637096-2-11970809855603631182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521637095; b=HMcPDlHKsIt5kcFIvhFKWiwzsaUCDUokDVUgd4kkPS8lkNo
    1MLftTP30Xpby0/cLizoxph7CQzkE8VOBfmNmmYOY1/Qx9tzhgIgpTwnhfEceEn7
    yXcLxv3c+tGgqsrxyRTiECzjp1aJqjAXjJchMhktV2dFDppvbDmO2ew0d6wRz1gA
    e5YvIDJsMD52eVB8MPff9kO0ivMs6l1tyC8aNVXpXgvtMi7NjiUIuNDaDuN+fE8f
    NdwyrDj4l5ImufR5V9l6iSFWlNQhRJ24byiGTJXicteXvUgb2W7x8n8LMwWqX2CV
    CD0fYTkkxS2Q5z2gwF5epXP9FeASl40W38Wy12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521637095; bh=m9dQ9a//DaArNUj5u7KrZVbMVa1tTmg9UzrVouuoyXM=; b=h
    P9iu9mdxBKKi57eJDtICimo/IvIdBQZCD6F+ddlhzDokTtDWs5PDYKqqGay8WlVZ
    aed07FCKCIHLKx9Th0NEv1n5o/eCRq+f+uWoiCiQlRzpDrtC2ed6iTS6tmkknxej
    dG1g7LUkHUjAlY5Dvko38tELzkFev9BsUK6V8Yvugt0ryshrAlRQLdruyisxgwgO
    7h6lv6b/FMwCtwrA+1Mp5FMDggOIPB1vWVx8+ulD/PQlVmMKq48g2jhlG5fSh8Yi
    JskD2O/esEcwzGZmYIGgG+l3NWDaY/6bL7n0iyXqc+i6L01NaxzvlX9iO04kvj3C
    G/VaLKtsqWjWwt/DLDxWQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCUM6M (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 08:58:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeCUM6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 08:58:12 -0400
Date: Wed, 21 Mar 2018 06:58:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/gvt: throw error on unhandled vfio ioctls
Message-ID: <20180321065804.5f818765@t450s.home>
In-Reply-To: <20180321090804.22430-1-kraxel@redhat.com>
References: <20180321090804.22430-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 10:08:03 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On unknown/unhandled ioctls the driver should return an error, so
> userspace knows it tried to use something unsupported.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index 021f722e24..be881d53c2 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1284,7 +1284,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  
>  	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static ssize_t

Absolutely, but I'd prefer to continue the standard behavior among
other vfio drivers, and adopted from elsewhere in the kernel, to use
-ENOTTY for an unhandled ioctl, reserving -EINVAL as an error in
options for a supported ioctl.  Thanks,

Alex
