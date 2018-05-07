Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeEGQN4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:13:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:13:54 -0400
Subject: Re: drivers/gpu/drm/bridge/sil-sii8620.c:2229: undefined reference to
 `extcon_find_edev_by_node'
To: Andrzej Hajda <a.hajda@samsung.com>, kbuild test robot <lkp@intel.com>,
        Maciej Purski <m.purski@samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <201805060754.UgJOHqtz%fengguang.wu@intel.com>
 <CGME20180506004653epcas5p395fb6e0f17a554f22485a3febd2054eb@epcas5p3.samsung.com>
 <6bea8cdd-8d9c-f474-12c6-8143e206ce9b@infradead.org>
 <35314d5f-7683-7769-f5a0-2cb0be1ae57f@samsung.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d429947c-e238-da71-94ab-022af0972b46@infradead.org>
Date: Mon, 7 May 2018 09:13:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <35314d5f-7683-7769-f5a0-2cb0be1ae57f@samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 12:09 AM, Andrzej Hajda wrote:
> On 06.05.2018 02:46, Randy Dunlap wrote:
>> On 05/05/2018 04:22 PM, kbuild test robot wrote:
>>> Hi Maciej,
>>>
>>> FYI, the error/warning still remains.
>> Hi M. Robot,
>>
>> I am cc-ing dri-devel@lists.freedesktop.org so that they are aware of the
>> multiple times that you have posted this kbuild error (I have 3 different
>> posts in my Inbox with the same errors; I may have missed some).
>>
>> I hope that someone there will have some insights into this problem.
>>
>> I have looked at the issues and concluded that the correct fix for this IMO is:
>>
>> config DRM_SIL_SII8620
>> ...
>> 	depends on EXTCON || !EXTCON
>>
>> However, that causes some unhappy errors from scripts/kconfig/ concerning
>> Kconfig recursive dependencies detected.  Alternatively, using
>> 	select EXTCON
>> does not cause any kconfig recursive dependency issues and solves the build
>> errors.
>>
>>
>> thanks!
> 
> 
> Hi Randy,
> 
> Proper patch was posted some times ago[1], and it was merged today to
> drm-misc-fixes branch.
> 
> [1]: https://patchwork.kernel.org/patch/10330653/
> 
> 
> Regards
> Andrzej

Thank you for the info.

-- 
~Randy
