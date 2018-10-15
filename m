Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B1C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F43208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+u0dv9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F43208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeJPEKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:10:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42892 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPEKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:10:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so9683131pgq.9;
        Mon, 15 Oct 2018 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWqF+YgcDjLi/P3g+a8dO4mmNeQ3j0U2pPA/EZ4jNVQ=;
        b=e+u0dv9LhPG/56bNKdYUERkv2htICow4c0kh+bLIjNETrFTHCca/SfGJjtYzc9/bBU
         bH4HLIdhonXX1Z8zAdMsucVmrn6rFVP5pJDOQeG3gYo2P45nOYdSg5Tp0yPECh09C7l8
         qUV6uNucLz76BFKqBtjD8PgqxHtEP9ihSvABlAnH0ITdJWtOdVCS8d6zS/kcbsUeXL/L
         I5A70vGh7SwHtOCl0UDeAdyIk6voaGRq+mHUBK4rZM0KNeUgARSa4COxLSfiqEnbFsdF
         j3hfmn1QfBklNhMqms+s1LdEE1n7jXEWtih1AEa2INgQ2QWnDq0qwYE83Xa3kpMyHQOV
         l+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWqF+YgcDjLi/P3g+a8dO4mmNeQ3j0U2pPA/EZ4jNVQ=;
        b=qAKiB4YIlrBaO/V7cHswEX9C5xx+GbVqwmcIHkpgsQo4XEWbtTE4GfICb0Eg0AWFTr
         rcNLu6p2kG6hC0P97s6HsPBbb1sDuz74VVbsIdt+wc+kVi8P77Vl9w7xhfl1+xkff7xj
         6phY4XK7buonyhcBcbKjHApuw5+7Owx+TcL3AUvYWfsowCzYrhv6Ah+jCm7s0nblCBfo
         Lx7UQjV/tG05w//PrI8FL/Jc0tZjZWWyywGGFYUn1CkWEhBZYj/W0LsF8AFRSaThqZbW
         edD1Dzp7iLuskve43Cl4sIv8in7f1aTreqL6mBnTdykBS4KdPphLDG18WVzc4v7X9wPG
         mSmg==
X-Gm-Message-State: ABuFfohj0KJtBeg2OcSDATqhDfuCE+mmB1DxfMMb4/IYugwm+Q/kdptR
        OZGF+QAToxXXuAWuIYTMdSk=
X-Google-Smtp-Source: ACcGV60JdZg9uWWGAdJAxlTOv380BaPJCCb3wipjeO0VTKR3TujAHxY/0dybGiZcD+eIiiAWpojRZg==
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr17410662pgj.255.1539635039268;
        Mon, 15 Oct 2018 13:23:59 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z26-v6sm14465935pfh.77.2018.10.15.13.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:23:58 -0700 (PDT)
Subject: Re: [PATCH v3 00/18] of: overlay: validation checks, subsequent fixes
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXTmY7v03m7NNZHVtzyU1Mwm0GYtOJQzmObFLASs=PEfLA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <34775737-d82b-b766-16d7-ac2de3231948@gmail.com>
Date:   Mon, 15 Oct 2018 13:23:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXTmY7v03m7NNZHVtzyU1Mwm0GYtOJQzmObFLASs=PEfLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 12:21, Alan Tull wrote:
> On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Add checks to (1) overlay apply process and (2) memory freeing
>> triggered by overlay release.  The checks are intended to detect
>> possible memory leaks and invalid overlays.
>>
>> The checks revealed bugs in existing code.  Fixed the bugs.
>>
>> While fixing bugs, noted other issues, which are fixed in
>> separate patches.
>>
>> *****  Powerpc folks: I was not able to test the patches that
>> *****  directly impact Powerpc systems that use dynamic
>> *****  devicetree.  Please review that code carefully and
>> *****  test.  The specific patches are: 03/16, 04/16, 07/16
>>
>> FPGA folks:
>>
>>   I made the validation checks that should result in an
>>   invalid live devicetree report "ERROR" and cause the overlay apply
>>   to fail.
>>
>>   I made the memory leak validation tests report "WARNING" and allow
>>   the overlay apply to complete successfully.  Please let me know
>>   if you encounter the warnings.  There are at least two paths
>>   forward to deal with the cases that trigger the warning: (1) change
>>   the warning to an error and fail the overlay apply, or (2) find a
>>   way to detect the potential memory leaks and free the memory
>>   appropriately.
> 
> I reran my FPGA testing.  The strings are fixed, no longer NULL.  I

Thanks for the further testing!


> have functionality back, my test passes now.  I'm seeing the intended
> warnings about any properties added to existing nodes.  That includes
> warnings about added symbols.  Below is a simplified part to show some
> of what I'm seeing.
> 
> By the way my testing is all using Pantelis' DT overlay configfs interface.
> 
> root@arria10:~# ./apply-static-region.sh
> 
> Applying dtbo: socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb
> 
> [ 1821.088640] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base_fpga_region/ranges
> [ 1821.103307] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base_fpga_region/external-fpga-config
> [ 1821.117359] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base_fpga_region/clocks
> [ 1821.130130] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /soc/base_fpga_region/clock-names
> [ 1821.143449] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property: /__symbols__/clk_0
> [ 1821.155357] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property: /__symbols__/ILC
> [ 1821.167074] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /__symbols__/freeze_controller_0
> [ 1821.180171] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property:
> /__symbols__/sysid_qsys_0
> [ 1821.192662] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property: /__symbols__/led_pio
> [ 1821.204720] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property: /__symbols__/button_pio
> [ 1821.217034] OF: overlay: WARNING: add_changeset_property(), memory
> leak will occur if overlay removed.  Property: /__symbols__/dipsw_pio
> [ 1821.231977] of-fpga-region soc:base_fpga_region:fpga_pr_region0:
> FPGA Region probed
> [ 1821.240144] altera_freeze_br ff200450.freeze_controller: fpga
> bridge [freeze] registered
> 
> root@arria10:~# ./apply-static-region.sh root@arria10:~# rmdir
> /sys/kernel/config/device-tree/overlays/1-socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb
> 


> [ 1823.805564] OF: ERROR: memory leak - destroy cset entry: attach
> overlay node /soc/base_fpga_region/clk_0 with refcount 2

That is indicating that an unbalanced of_node_get() / of_node_put()
exists for that node.  I'll have to update that message to be more
explicit about that.

-Frank

> 
> Alan
> 
> 
> Alan
> 
> 
> 
>>
>> ALL people:
>>
>>   The validations do _not_ address another major concern I have with
>>   releasing overlays, which is use after free errors.
>>
>> Changes since v2:
>>
>>   - 13/18: Use continue to reduce indentation in find_dup_cset_node_entry()
>>     and find_dup_cset_prop()
>>
>> Changes since v1:
>>
>>   - move patch 16/16 to 17/18
>>   - move patch 15/16 to 18/18
>>   - new patch 15/18
>>   - new patch 16/18
>>
>>   - 05/18: add_changeset_node() header comment: incorrect comment for @target
>>
>>   - 18/18: add same fix for of_parse_phandle_with_args()
>>   - 18/18: add same fix for of_parse_phandle_with_args_map()
>>
>> Frank Rowand (18):
>>   of: overlay: add tests to validate kfrees from overlay removal
>>   of: overlay: add missing of_node_put() after add new node to changeset
>>   of: overlay: add missing of_node_get() in __of_attach_node_sysfs
>>   powerpc/pseries: add of_node_put() in dlpar_detach_node()
>>   of: overlay: use prop add changeset entry for property in new nodes
>>   of: overlay: do not duplicate properties from overlay for new nodes
>>   of: dynamic: change type of of_{at,de}tach_node() to void
>>   of: overlay: reorder fields in struct fragment
>>   of: overlay: validate overlay properties #address-cells and
>>     #size-cells
>>   of: overlay: make all pr_debug() and pr_err() messages unique
>>   of: overlay: test case of two fragments adding same node
>>   of: overlay: check prevents multiple fragments add or delete same node
>>   of: overlay: check prevents multiple fragments touching same property
>>   of: unittest: remove unused of_unittest_apply_overlay() argument
>>   of: overlay: set node fields from properties when add new overlay node
>>   of: unittest: allow base devicetree to have symbol metadata
>>   of: unittest: find overlays[] entry by name instead of index
>>   of: unittest: initialize args before calling of_*parse_*()
>>
>>  arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
>>  arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
>>  drivers/of/dynamic.c                               |  68 +++--
>>  drivers/of/kobj.c                                  |   4 +-
>>  drivers/of/overlay.c                               | 298 ++++++++++++++++-----
>>  drivers/of/unittest-data/Makefile                  |   2 +
>>  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
>>  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
>>  drivers/of/unittest-data/overlay_base.dts          |   1 +
>>  drivers/of/unittest.c                              |  96 +++++--
>>  include/linux/of.h                                 |  19 +-
>>  11 files changed, 439 insertions(+), 122 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>>
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

