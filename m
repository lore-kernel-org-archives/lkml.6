Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDQPoG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:44:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45637 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeDQPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:44:03 -0400
X-Google-Smtp-Source: AIpwx49PBwnvhN8o2s1bvggdoqEHeVd5mzXuneCioGypIWV/1fxb00L9L8zas/gBLyjLyI9DAwcyxw==
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
To: Alban <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
 <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
 <20180417165420.423a691b@avionic-0020>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
Date: Tue, 17 Apr 2018 16:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180417165420.423a691b@avionic-0020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for explaining,

On 17/04/18 15:54, Alban wrote:
> This will not only allow reading the calibration data from nvmem, but
> will also create a partition on the MTD device, which is not acceptable.
> With my proposed binding this would become:
> 
> flash@0 {
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	compatible = "s25sl064a";
> 	reg = <0>;
> 
> 	nvmem-cells {
> 		compatible = "nvmem-cells";
> 		#address-cells = <1>;
> 		#address-cells = <1>;
> 
> 		calibration: calib@404 {
> 			reg = <0x404 0x10>;
> 		};
> 	};

Why can't we make nvmem-cells node a nvmem provider in this case?
Which should work!

--srini


> };
> 
> Which would work fine as the MTD code will ignore the nvmem-cells
> subnode thanks to its compatible string.
