Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeDIPRs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:17:48 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35264 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDIPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:17:47 -0400
X-Google-Smtp-Source: AIpwx4+O9TmqECatI4RHVAPrGa5ju5zP5a96tAQmEgjffrI9jhNSxqMhNxBoD4X4Rk2MsjtPMxhKrg==
Subject: Re: AMD graphics performance regression in 4.15 and later
To: christian.koenig@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com, labbott@redhat.com, akpm@linux-foundation.org,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
From: Jean-Marc Valin <jmvalin@mozilla.com>
Message-ID: <76a30815-28e3-e798-03de-a3cdfade4c64@mozilla.com>
Date: Mon, 9 Apr 2018 11:17:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 05:42 AM, Christian König wrote:
> Backporting all the detection logic is to invasive, but you could just
> go into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the
> other code path.
> 
> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.

Do you mean just taking the 4.15 code as is and replacing
"#ifdef CONFIG_SWIOTLB" with "#if 0" in
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c or are you talking about using a
different version of drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c ?

	Jean-Marc
