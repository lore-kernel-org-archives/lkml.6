Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6EEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D721206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uGdUklNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D721206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeIKXyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:54:11 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:35215
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbeIKXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536692011; bh=x0IQcDZESlWr9gZq/q/OnRHWRbN5nRknkuEzy+8nh9M=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uGdUklNUpQyBSj63T7nTCZ9fCCwjd26QxWH4O+4WTKRHTGHeBeu0qXI+/sckh/BMa2TE3cbxw9VnMRZymMZ5Onz5aaBKEC1Rzx2xd8nstedVdxZgJ3cDLL03WGHhe7eMGSkKXUjXlQv5arBD0zah82uTSVuYsk2jHLSvRww1z+KrxmIM2l97B35i0T0lEPx1/K/y5XYAddV3sR0oTP7aKRIVhhDobmtE2dloajIB+DsO73I2eShar+FRH4SFTsQTkdwmqEucIpKzr9q4nyBkU43U9JVf5NpcRWZY7lp28RFSbysKbhMSFLD56BH7ZxP0K9cR3KYSoVZP6oSfgpyIQg==
X-YMail-OSG: 49PNrmgVM1kUZBO_simrDIMAszUTb834YWSaW1deIZNJHW76SxlYo.N52wKDuWJ
 Xf0Dd0eXcT_9GahNE_E0ALU2MfkrIZrM_YtEQZ4Ja.qcbEsm9Vb.hNME9ciLIBKj9uUX2Jxn4lWI
 DqTEE5P3N8omhWEAaFZtFxauX5S6KyANOAW09g0cbReFDlwJSggtSeSm5gzNGaLMp2pYLRL4grBl
 nmbMXIsK7T0l80jabp30MBLEorwnGO2lVZmyl0SQGNg5zMF3OValMdDGHJqrHvYI0rRNFj6V8mTt
 gG.i1KeaSCrcYjotbi.qZmdSEVHs6PSz2nsa_gDOlemXTZYfKJqw1oyj1QBZqz1R44iVH492TeXH
 YfqUgbfsOnU7aWPAPqeLc8ut30FdwmCsbr9eQeoAr2Yys.G.HJA3.bHGMYfFTAVNrUU6.EWG.Ucu
 Hhq3YOJ6S8qJtnBYDoFuGoBJvRJEtOCOLF91c3YECRg1V6B0xGJN7oiDT7iMCO6741kBvH7qHEN9
 dri4VLO23cJBQeoe4U6u8lir5hRbZmJwncQ6YP2_Vgcl33HSjA0MfuRny510Nkfy1HI3gPK8LDKM
 DRDIMgl_uDhP8QZXOfUCzPoRz3rEKCDuCTSxZJpOeqFvZFwTiyHI6Ui9RSlreHIz9C6sX2DaxOnM
 HWAYBXGRWCGDEbIQT0xsaDIpFVHIMBphuIeWbK4QCmYK1c_E2V9thIckwrdxEbnSxCo8CmyAyYlP
 cAt34PyjLMpbnK98kTpgEkRwpd2VGwSQJpmL2Px8R6qHl7hAn1qNs_sokRi5zgjKwKRY6MgIqG5Q
 i6RiBULlz_0oybwCO0mvZCIjE6K0fxWfJMJe24LdtVtR1Oj_gFCaq815H5ZajBBff7x.gynnQDuH
 jtpStZX64wmjbsAalto2q_OfLY.ui6nuZeOvsc4SNX3JoAvZJCTIZOV2f2zbLIc5QhNyOzpm9dgi
 LQIgrHppAT1cdryFgEzgdJMezw7u0Yi7lKN_RD9Gj0lgC5GI6ECjY91UDWq3MGbKG8d0BDUMgVp3
 9btGr1QKSqIg_NoMOPEIqu6og.Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Sep 2018 18:53:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f99bc55f71280c8f948b706861c3ef54;
          Tue, 11 Sep 2018 18:53:30 +0000 (UTC)
Subject: Re: [PATCH 4.4 22/79] Smack: Mark inode instant in
 smack_task_to_inode
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        James Morris <james.morris@microsoft.com>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180823074918.641878835@linuxfoundation.org>
 <20180823074920.150267602@linuxfoundation.org>
 <1536689647.3024.129.camel@codethink.co.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ec9602b1-1c9e-58e7-85be-f98f39febaf3@schaufler-ca.com>
Date:   Tue, 11 Sep 2018 11:53:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536689647.3024.129.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 11:14 AM, Ben Hutchings wrote:
> On Thu, 2018-08-23 at 09:52 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Casey Schaufler <casey@schaufler-ca.com>
>>
>> [ Upstream commit 7b4e88434c4e7982fb053c49657e1c8bbb8692d9 ]
>>
>> Smack: Mark inode instant in smack_task_to_inode
>>
>> /proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
> That change ("/proc clean-up") only went into 4.18 and hasn't been
> backported to stable, so does this make sense for earlier stable
> branches?

No, it does not.

>
> Ben.
>
>> resulted in smack_task_to_inode() being called before smack_d_instantiate.
>> This resulted in the smk_inode value being ignored, even while present
>> for files in /proc/self. Marking the inode as instant here fixes that.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Signed-off-by: James Morris <james.morris@microsoft.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  security/smack/smack_lsm.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -2260,6 +2260,7 @@ static void smack_task_to_inode(struct t
>>  	struct smack_known *skp = smk_of_task_struct(p);
>>  
>>  	isp->smk_inode = skp;
>> +	isp->smk_flags |= SMK_INODE_INSTANT;
>>  }
>>  
>>  /*
>>
>>
>>

