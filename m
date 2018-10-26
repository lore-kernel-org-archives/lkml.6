Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83910C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F1920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oS8YqKI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F1920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJZQtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:49:35 -0400
Received: from sonic307-1.consmr.mail.ir2.yahoo.com ([87.248.110.121]:35463
        "EHLO sonic307-1.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbeJZQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1540541609; bh=GediNiVKngPOCK6y+8ihH+VHhd3J7K0rRPl/ZsD5kI0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oS8YqKI5RCudKjkx/z0IaB8fxXryRtkDIFieL8cFclsKbUaoGjy360QnP8PTd2KvDfM6orfi/xf3U1KWR+9tF8eLewC7EAPp28IbZDmC8KmBLqaUtUNeoRongVRrd95nPgnahQCck/es5xlddaO8qapRlgoRadlLhvV0lzUfXDRL8RzptLjStYTcKMtJ7XGWKukeP1hOYdFe9/NqlF6L5A1hHBDOssqZpXC7Jx2ik78J7+xmBov4NqgeUVGxLtjFRsLrbj3vfwWtVv6rh8jmcyupcEhcUlourObNx4XpBb/RW5s+2uVsz2U3MNq2iSC7r3WhqIUqXG73gKX2O4K5CQ==
X-YMail-OSG: evZHxPoVM1lbhkO3pKlZ8FEJtt.ARXCATY8IfUx_pmu2WJ21eEIGQKz3iRc7ZM_
 3ViDI9RI0SLPGobHdFMK.BFoce1_BMX7puWrMV7QxOjswuxBgOBB3N4bJAPJhjYqmaJSZph0ITFk
 yN.oRqlauV9EanL_sK5BS6bsHiCCCWjHBz6c69lc8.uPedzXmV0.X.ovkiVWaWa7D35pcoUv.AcG
 VuRBSnEw03988udCdETCHrmLpUecHCkyReoUn3Wyluf4jpaFnQXt92KgKHwEXShBoXYHnvXMGG78
 1QOvTqZJSgHpJtTsYszWEzDGqcvLJ6nhHGkz9pKJVP6cc.yFKatSaJ7qy2naTalnyjtcb3dBy8u9
 AfMW8TazNV4gcMKKQIIyXEYd_aFuAcRZmbAqX1lLf0ANrHFbxeO8zq0r2sS6aMOH2N3JI6.HkYUg
 ZC9y174WA5J31mAFFTt4XtEP2vPryEVH.g_soUzzayVO4khTwfUgxcAtQ_oqZ39R5ZsK.y29z4zW
 bcPt85zLFWS6.2jLAijlvLaKlmNRHls0nO4FMHueiBtqBNFPyOqQj.HRut7jQ1Epin2CdxOKuU.I
 5HSeVQ6HC.XQz05cL_d.cthGdvU2rhrgTh3k2hhGbvpUgXAyzQvsoCzx5VewuOGR2BFns_T0BUmO
 8uWtD4h.Yhy2_2XIti_Nf1CpwNi1GYFEWOjOZtyvyBHK5UywZSzCQ_kIJCBvlvWnpra10192eg3g
 vhjz4Duy9T3EDgEWzM9ol6NJTxxu98W46GSdyrWQUbBtuChCGDjM4mvkZb2NekOoG8EYP9IfQ62C
 ot.cFsoN6PnyqHnon1brCjVgYRZINc6xsGwneiOJXci7_u01LkFgkXlGwZMaKeVi0KNIJxMTgdBT
 gz52S83_4_ptuYlg1IjdKTwbc8XicEJkdpuCtVbpUcAqiXvLAYCWKzBluKbMverZ1s7pNDy4Woci
 ZTMmGApu8Tq_QDfutJM0r_.LS54NQU1IFGZyFVBWTobqSWF2W7Pigy6iKVNL9tw9xndwgJJo5Zfm
 flKHG5pSptdDiHz0tSoxeHVKfu03u8zlLgUVQ6704iDSAvlwGSENlf89MDfloUslhqPeIV9guuXY
 KNfSKQfkA.R8NbQyvOLN4DxjkSN3cBV18Lp3J5zi8EeKnsMXkBB8oYM4qEFDytKbbZxIAcaR_F_C
 J2K295B8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Fri, 26 Oct 2018 08:13:29 +0000
Received: from 185.7.230.216 (EHLO [10.101.214.177]) ([185.7.230.216])
          by smtp414.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e55f25365a03122d990e2367aad2a64b;
          Fri, 26 Oct 2018 08:09:28 +0000 (UTC)
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of
 syscalls
To:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     luto@kernel.org, rgb@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, carlos@redhat.com, linux-audit@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
References: <cover.1533065887.git.rgb@redhat.com>
 <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
 <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
 <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
 <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca>
 <20181025080638.771621a3@ivy-bridge>
 <CAHC9VhR02siURgadQs0EikcOm0d_TPAi4jJYCx4NkA=wQ5rjSA@mail.gmail.com>
 <20181025122732.4j4rbychjse3gemt@madcap2.tricolour.ca>
 <20181025175745.5b2b13e9@ivy-bridge>
 <20181025173830.4yklhnrydt5qvr67@madcap2.tricolour.ca>
 <CAHC9VhScaG8aOFYRV5hPXEKob1QRth5YFEbHNY=ZgKKAKxBBsQ@mail.gmail.com>
 <20181025235527.15a39d75@ivy-bridge>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e1d8a8cf-5013-ffbe-923b-604851de836d@schaufler-ca.com>
Date:   Fri, 26 Oct 2018 01:09:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025235527.15a39d75@ivy-bridge>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 2:55 PM, Steve Grubb wrote:
> ...
> And historically speaking setting audit loginuid produces a LOGIN
> event, so it only makes sense to consider binding container ID to
> container as a CONTAINER event. For other supplemental records, we name
> things what they are: PATH, CWD, SOCKADDR, etc. So, CONTAINER_ID makes
> sense. CONTAINER_OP sounds like its for operations on a container. Do
> we have any operations on a container?

The answer has to be "no", because containers are, by emphatic assertion,
not kernel constructs. Any CONTAINER_OP event has to come from user space.
I think.

