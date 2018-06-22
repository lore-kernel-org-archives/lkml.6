Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9EFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509F3243D1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lB05iYZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509F3243D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeFVOhJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:37:09 -0400
Received: from sonic313-19.consmr.mail.bf2.yahoo.com ([74.6.133.193]:41452
        "EHLO sonic313-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751312AbeFVOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1529678227; bh=6rG/nuQosN3Bsl+rMVBwmXI/Cd4i8kRTZOCtIA5rAi0=; h=To:Cc:From:Subject:Date:From:Subject; b=lB05iYZB1200XaREchGqTnu2s8bp5mkd0/Gn2wuNfqQeLo0ljKFUdultY39ad05ubhS3PBSWutfOpB6TBmUGyyengXJ4HqsThgelHt+9TbPFwSidYDxDP4Wtyf/+TYwnEbGmc55fU8tUt3Lkz8K5DYmygI1oDEocnPnACCqOsRXTsYJpX1kfDsXxt5waPTGdNhWnIcd/K5VmTAlbhiQcU9bvcWQaGrNhxL2ghVmoetAjCRbEAEQsUDFf09UkongHBSoQDbCJ7MMEtzPKtsfMjbfWcqgNLOZUw9hwVO4dIrgjX0UTJR0m9EGyfactKOeT6vCnlgplZuWXtjEQZZ4lrQ==
X-YMail-OSG: Myk7XYYVM1n0AlH.6xic8IrCIx6vQVS7cIxVGbTWvWlDx_Cu9JGg6hrDL31J.Ka
 kzHThR6ZbtfNEXEw_pMiB0gGnvpQQnmAMQv85vnzlK.fv2t2H2lz0vhJu6tOMhgZwK_rCmktjBhi
 Y0uWFHjyQYN9kDkuRLErU.3PjWDdwIsGrA69kJOzl_1yGCF8DfNwbkbEBe5ybQpsHapynlngWJAb
 2M7.MfSeAT.9xt0RYZqPq.nvSa23FhssiMORFejb0tN.dTWz8aNN8aqy.Nf65SeW85vw2Fo7enbF
 Z1l4NAevioTarLYhyNMBNgAl2LnJL_YDSAbjSxqbJNsHcrNTzQSm2UC53gfCvsCRkmKzpbexnDgW
 3zbfwJ6WBjGILoVOdRZWe9nwxz7ugcRg_yZ7PP8h2QfLkc99BE3sdbvjI.2cLcEmz.kJgUyvHbvh
 1uvwltrmaFc5q0l6AotYPGJm4vyt.TwzNG0C.YKF9ju7EwiHM2kmVFYkrLZtzEL2qoUTr_ACgLIv
 wnilTj6Or8jemRa_0CaUFU24BEK5ux0r31cT9d1XLFqn1EHIBxdfJyj9RKTgHCXl7VnzNxZB8cWw
 v.5Wgq1f5cGY6dFEJP5BOTUEAYjGBrCD5_Dc1ojT.yQpPKKCgz0VKFLe2RIYnyTMhYvBOhXJlfyT
 oaWW.nIlMKO6TmLu0OI_D4.HoUJlGjvPdke042h_STnqwMX.kynVb4VURZiPgy3jl6B6BtK2eRyf
 fC9w1aHKLH08oKr0cOegGkkJzYWGnLc1V2RN_kLcxAHbmuoFHT_5XN9oT6FaU_PJQZRtQB5pVok.
 qckQx1W0eVlI4LZkRZJ.kyUU85MW_vfgCdoRXLnCYZAzoY3L.HmpLPcda51FYEuOxlr8qPC8E_47
 _wphxOkpwnHQGDhotklFanR7RC4lIl2KSl_TnZ893CPEk3gZINb9R27353TsMX1_hYlj_xkR70YL
 h3Gcv5W2sxX3XAeHf7f4HPu0OmO8x8h3E.RVesgTzGdfRikiSh3IsE5o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 Jun 2018 14:37:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 55a35926a0ed68bbcb2891aa1d65f576;
          Fri, 22 Jun 2018 14:37:02 +0000 (UTC)
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: 4.18-rc1 regression in /proc/self xattr handling
Message-ID: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
Date:   Fri, 22 Jun 2018 07:37:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regression in behavior regarding xattrs in /proc after:

commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed May 2 21:26:16 2018 -0400

    procfs: get rid of ancient BS in pid_revalidate() uses
    

Prior to this change lgetxattr() would provide the correct attributes
for entries in /proc. With this change I see that while the behavior
remains correct if the procid is specified, it is not when "self" is
used. On a system with Smack enabled, where the shell has the Smack label
"Crackle" I see: 

[root@localhost linux]# attr -S -g SMACK64 /proc/self/attr/current
Attribute "SMACK64" had a 1 byte value for /proc/self/attr/current:
_
[root@localhost linux]# attr -S -g SMACK64 /proc/$BASHPID/attr/current
Attribute "SMACK64" had a 7 byte value for /proc/1716/attr/current:
Crackle

These should be the same, and in the past have been. I don't know
what SELinux expects as far as attributes in /proc, so I can't say
if the problem is manifest with SELinux.


