Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeBVH50 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:57:26 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46636 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeBVH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:57:23 -0500
X-Google-Smtp-Source: AH8x227N+yrqIJPbaUTgUBdgL6lUeqwGX1X7eIgbn1rn84CKhDm6n0XgyZHcpyxn9ye3xMmzHVUFiw==
Subject: Re: [PATCH net v2 1/2] Revert "tuntap: add missing xdp flush"
To: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mst@redhat.com, christoffer.dall@linaro.org
References: <1519280658-4918-1-git-send-email-jasowang@redhat.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6b629082-c8cf-b53a-9ea3-b9da382f65c9@cogentembedded.com>
Date: Thu, 22 Feb 2018 10:57:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519280658-4918-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 9:24 AM, Jason Wang wrote:

> This reverts commit 762c330d670e3d4b795cf7a8d761866fdd1eef49. The
> reason is we try to batch packets for devmap which causes calling
> xdp_do_flush() under the process context. Simply disable premmption

    s/under/in/.
    Disabling preemption.

> may not work since process may move among processors which lead
> xdp_do_flush() to miss some flushes on some processors.
> 
> So simply revert the patch, a follow-up path will add the xdp flush
> correctly.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Fixes: 762c330d670e ("tuntap: add missing xdp flush")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
[...]

MBR, Sergei
