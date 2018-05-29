Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933911AbeE2MTJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:19:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933525AbeE2MTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:19:05 -0400
Date: Tue, 29 May 2018 13:18:57 +0100 (BST)
From: Justin Skists <justin.skists@juzza.co.uk>
To: Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Message-ID: <1478759754.17398.1527596337445@email.1and1.co.uk>
In-Reply-To: <20180529113725.GB13092@rapoport-lnx>
References: <20180529113725.GB13092@rapoport-lnx>
Subject: Re: [PATCH] docs/admin-guide/mm: add high level concepts overview
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:tf9yff0S+vRchjRRFUfqUbTuUvmfskTELu0hcqnIUHWaw4uKARF
 4TPt4V/x7CC7h5NIppWYbLbKsuRnKB56g6W9fJhABpf8/Pkm5DhPfU0d0OKMwse61un5g8l
 oq6s8f7ve9h3RcsK46sho1d/8vBCyxG9zLIzcXhXglKiJI4Em8T7dHzGweRSmKWghH++ALG
 gdAku1BN7CVJwnTSD5VKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JbdSI3FAteg=:lOj2ldpepZMVhBvpq9dIlV
 xQEgCdW9h0NZTW9PTIwXMc8/yiEmld603+IWD6CNlayPNb5zgdODMi61IQv8k9H/RIAU2PWxA
 a4lwC/gdiUmqBF5h6m5qhhgxuPI+0NH6QOJ6gUtnvUayrqDY3abzLI/abCa0/OsaGS53de5rI
 0VMYdeEKmbK2Rf4Jg/n50IVUdWSp/v3IAYa/pWUDd+nkYuwJ6UL25VhjUlA0+SKm16fXeuKnO
 q9pKbv8U/vBi/Z/bV/leGZwHd7534/3Mpp2RmdeMeMRV7s/078BILIC1jUPMXWDXcNg+ik8Fk
 9plxdsu0Yz8aNw3HuYNMgGV3slMs9OOVsJlMifZEiqxzbDJU1/bZMLBnFXdI0AQg7cTLn/i20
 J802BKjilN0rKJSjeZgn2SULM0v6bk3lSgTC0ViWe+813YiKORoIKAnmc0LVoqfimjg1oLLXi
 pxjRXhhdrVtvOsABrwbiGpEWKQBt42hyG//4fsJqlWfr+9oDtRYZ2CebNnYmZXafHgdb7UEJa
 6RK90yPn8PWVRfJGRqfTKikGdjUJ3G4XAnFx+TV740WpQaU3BBM12Q567dVCtHQWmH+4Yqf0Q
 dpS0/eP+lGrQEIpCZkkgVc0ZsHgC8mAHqIe8mVEblekUCAmEuaBTuTCA3rGpUH4FufX/dkYBO
 4fCvuTxa9Ib7r6DbUbnleHPKea2HK2yE5SxL4XoNHEdOwpFW/EFBqjpCcGRgdsqCkFDSPI6l+
 ZSrKIBB7Kv8HWLrl
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 29 May 2018 at 12:37 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 

> +=================
> +Concepts overview
> +=================
> +
> +The memory management in Linux is complex system that evolved over the
> +years and included more and more functionality to support variety of
> +systems from MMU-less microcontrollers to supercomputers. The memory
> +management for systems without MMU is called ``nommu`` and it
> +definitely deserves a dedicated document, which hopefully will be
> +eventually written. Yet, although some of the concepts are the same,
> +here we assume that MMU is available and CPU can translate a virtual
> +address to a physical address.
> +
> +.. contents:: :local:
> +
> +Virtual Memory Primer
> +=====================
> +
> +The physical memory in a computer system is a limited resource and
> +even for systems that support memory hotplug there is a hard limit on
> +the amount of memory that can be installed. The physical memory is not
> +necessary contiguous, it might be accessible as a set of distinct
> +address ranges. Besides, different CPU architectures, and even
> +different implementations of the same architecture have different view
> +how these address ranges defined.
> +
> +All this makes dealing directly with physical memory quite complex and
> +to avoid this complexity a concept of virtual memory was developed.
> +
> +The virtual memory abstracts the details of physical memory from the
> +application software, allows to keep only needed information in the
> +physical memory (demand paging) and provides a mechanism for the
> +protection and controlled sharing of data between processes.
> +
> +With virtual memory, each and every memory access uses a virtual
> +address. When the CPU decodes the an instruction that reads (or
> +writes) from (or to) the system memory, it translates the `virtual`
> +address encoded in that instruction to a `physical` address that the
> +memory controller can understand.

I spotted an errant "the an" in that paragraph.

I would rewrite that sentence as "When the CPU decodes an instruction that
reads from (or writes to) the system memory," ...

The rest of the document looks good to me, and a nice overview.


Best regards,
Justin.
