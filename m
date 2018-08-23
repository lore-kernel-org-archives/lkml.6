Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2310C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A920A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932A920A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHWUET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:04:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:58603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeHWUET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:04:19 -0400
Received: from localhost.localdomain ([196.52.84.82]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Mh6lB-1fX6Pi265J-00MMa4 for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018
 18:33:47 +0200
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Disabling CPU vulnerabilities workarounds
To:     linux-kernel@vger.kernel.org
Message-ID: <3ef48582-3a0a-e41c-4aee-54b5a38056c6@gmx.com>
Date:   Thu, 23 Aug 2018 21:33:46 +0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5fuYoS4VQ9V8wu+8685JlaBKlEh6vVXi/OBlVgSEQnduMB1VH2s
 zHLwdlS/nvKmdZmLhhBT0JeJPd+02Al+wvkz4dxJaiD9JlQzFF7h/kXSzupUwK33rOJcGLV
 D97bTyR4e9o7tQK3A758uweM6KIU7D2gzv8n7L8gSlz4GtmiuAKA4aRQj/A6O+wf84o8lSE
 1eNo3T3iQSE6pN76I4Z9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yaw3JeVYAFM=:COw99ufY6+1WVYpaRVPNHi
 JPuPXjdPrbQ+TttEEHIRTpAyduC6sWAXKL5vL6aQMcWvHN6FQJQSmN0fM5zeI++pgCbP6h5JR
 ObkCanlZZ7WHBf4QS1GZ2M+Z0gOsRUUAvdjlrUWEqj0ZCCd1E8FAM97lDrBhbY9wgHBfkBmLW
 6lHJ6To8KLwhYnio7V5OjLV1JzfNZ9vrn0VetMfRplmsoLRCcxdkV8cTDALPOXcFtsWCo6B/v
 neHOdrBJOWYv+At983kjx7pEykJAJGdX50tUjdwnDUc7v1we4OyYXsvA9PPm5nxPQoSQxLAX+
 UpofN+fYgYMi16XGlO8vpbK2bCtc0EcAchOrkHzYBGqiDwLmWyUlnO2Yc1fAY3hHr69kXSliS
 rUMNTtsw3dQdDa46zEVH5QsP3aUixhUsOU0PlNU1f0J/w7T0eRtqY914j6fuXKulRKEDCzzCL
 C9CSDcDZJs8MEdUytAfMKSlZx0nYpZXMZEnw8p6n7OJjRmHaThbWQmSPB+V7u/HOUHtuwRgBq
 suLQigB801qO29KxQTliza5m731GuZM+tirdcjvrOp2v7O5UTti7DaDab0n7gp30DRd1bcV6s
 15d2OrEYp+Mn0seW953PTkR1LK0I+9spqOVejylFxUVzIwwMVY5K4zUDO0fTG1TY7NjFFExYw
 qx29iERz6t8wz41TYnftSLznQWmoN9VlH77NvGTxhGj+sZX8zWuqEPliYZ/DFjrP6cfnIYIMV
 Owg0qdaBBrvHjNGrIk0AWGc8g9VuloQrQZeVmGY95BJ0apraEmmqx+rmEmdTLI0+TooQH/3NC
 MsAe+jn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

As time goes by more and more fixes of Intel/AMD/ARM CPUs 
vulnerabilities are added to the Linux kernel without a simple way to 
disable them all in one fell swoop.

Disabling is a good option for strictly confined environments where no 
3d party untrusted code is ever to be run, e.g. a rendering farm, a 
supercomputer, or even a home server which runs Samba/SSH server and 
nothing else.

I wonder if someone could wrote a patch which implemented the following 
two options for the kernel:

* A boot option option which allows to disable most runtime 
protections/workarounds/fixes (as far as I understand some of them can't 
be reverted since they are compiled in or use certain GCC flags), e.g. 
let's call it "insecure" or "insecurecpumode".

* A compile-time CONFIG_ option which disables all these fixes 
_permanently_ without a way to turn them later back on during runtime.

Right now linux/Documentation/admin-guide/kernel-parameters.txt is a 
mess of various things which take ages to sift through and there's zero 
understanding whether you've found everything and correctly disabled it.


Best regards,
Artem
