Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELscr25kaL5x5YNezQ3T+rWPqicsvdqAFZmU7eZfSWrltiGStnHAvdjWLbdinieV9NZ4GLnY
ARC-Seal: i=1; a=rsa-sha256; t=1521186968; cv=none;
        d=google.com; s=arc-20160816;
        b=iKN97h9nOjnmhg7VdZS69F/N1pqsDXg1h8kzfOY9hMYe/Al341U8WR+mIkbEgGGaG+
         cR63y35wjF6AANw8whpi16Hl/KgsI0jlUL5QQzv5zim6kqjCKQVj50UMDFxA2i6U+KPn
         wIr3fGImSqz0qHs/76uwgWtmiqmjrp4OBWdT22hNJWOEzDMb9ZpDwjhB2hd/BjBdxCIf
         tBf0qctohSLsQQe/yBZjOjA6o27Tcpk/lKsbV5NGMXDAG4WjZ3TJAicDovE4vVs/ky9y
         vHCf/cLqQ0IGX8sJ8OqBZlosZYnNnuVXeg2376EYsVVV/UfeQB2mnTgxsB2vBokTo6I8
         bCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=W8zI6HNgef0M8OzoeQPog31j8LPrV3/mqz8celSbRXg=;
        b=ZLacWfQTedqs49FW8X9mWGiIJf26skKXQr7BM2+8y9gQw5dab6HUFMWDajI39FxKOe
         TYPoHHyNg+oLr/HH/AhRGKopkT+e2SRgiyW3UrP/ENLe5DGrKRKGPBqEm9uLuDhJleDK
         a3XjbLCmL9swcw6/xWF7Aa/MT1VCnAz8kKpycIYMJoX8PUROLiHPaqtPXEjwNhGzRlHH
         M4Dkod9DzaN3o2dWj2+CpjTu8uJqPwSptsL1Prq4AmCz7Ovf2V+l6m7/ZKL8lz6lbdNp
         MR9iBfVryA/eA74qGp1GimpnBBZBsc9PMwXXaIHrXvK/D8z0j4OOtQqtSQVxxnjr0+iy
         aRPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCPHzz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 03:55:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeCPHzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 03:55:54 -0400
Date: Fri, 16 Mar 2018 08:55:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] Add udmabuf misc device
Message-ID: <20180316075553.GA11982@kroah.com>
References: <20180316074650.5415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316074650.5415-1-kraxel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595079572079958094?=
X-GMAIL-MSGID: =?utf-8?q?1595080146968654395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 08:46:49AM +0100, Gerd Hoffmann wrote:
> --- /dev/null
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,261 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

No SPDX line or copyright here?  You put it in the .h file :(

thanks,

greg k-h
