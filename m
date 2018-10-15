Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0933C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E8DJjl63";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d9vB84Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJOSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:42:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:42:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A109612F6; Mon, 15 Oct 2018 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539601037;
        bh=TWfSBoQ0mxq8cg7ulnTwJYxl89tQRs/UpCsUSkomiRg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E8DJjl63iNyq6ow2wzeb3RUiIeqGIXGIg+MMCeTdC1SllacSf2WHHaoMnYq9eai4P
         3MPE9+5r70SobsHn+on1B7rciO+fkgZ1xF31tJtD7Z2X2LAB38BhZsqf8kD3EBsiho
         N0FnlhRFMKWcVtJ1gwLwjkUqupfaEPWYjgzYn3eE=
Received: from [10.206.24.177] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CEAC604BE;
        Mon, 15 Oct 2018 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539601036;
        bh=TWfSBoQ0mxq8cg7ulnTwJYxl89tQRs/UpCsUSkomiRg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d9vB84PkKqeZ1utzqjv6hih0i5bse7FokizGKAiRJN1Mg6/D83RsoGL1cf0+bMJT/
         3wnbBTnZVeYfsX9rou6027gItYZv/YtJg+3K09r2Yx4mcmm5hbAsERQV4bfMB8STsT
         48n4IxZ07owcFIKtDGLtZ5kKHph6hLOWOReUCNdU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CEAC604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V14 1/2] scsi: ufs: set the device reference clock setting
To:     Doug Anderson <dianders@chromium.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        jlbec@evilplan.org, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
 <1537770516-28410-2-git-send-email-sayalil@codeaurora.org>
 <CAD=FV=UrHF0Bp8DMKz_FjeGT_px6MJpkheF7RcmDxNC3=RPG9w@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <5c08dcb3-f5e2-47f3-a75d-46802643250a@codeaurora.org>
Date:   Mon, 15 Oct 2018 16:27:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UrHF0Bp8DMKz_FjeGT_px6MJpkheF7RcmDxNC3=RPG9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/13/2018 4:20 AM, Doug Anderson wrote:
> Hi,
>
> On Sun, Sep 23, 2018 at 11:29 PM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>> +static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
>> +       {19200000, REF_CLK_FREQ_19_2_MHZ},
>> +       {26000000, REF_CLK_FREQ_26_MHZ},
>> +       {38400000, REF_CLK_FREQ_38_4_MHZ},
>> +       {52000000, REF_CLK_FREQ_52_MHZ},
>> +       {0, REF_CLK_FREQ_INVAL},
>> +};
>> +
>> +static inline enum ufs_ref_clk_freq
> Please don't specify inline.  Let the compiler decide whether inline is better.
Done
>
>> +ufs_get_bref_clk_from_hz(u32 freq)
>> +{
>> +       int i = 0;
>> +
>> +       while (ufs_ref_clk_freqs[i].freq_hz != freq) {
>> +               if (!ufs_ref_clk_freqs[i].freq_hz)
>> +                       return REF_CLK_FREQ_INVAL;
>> +               i++;
>> +       }
>> +
>> +       return ufs_ref_clk_freqs[i].val;
> I think you'll have less confusion if you write the above as this (untested):
>
> for (i = 0; ufs_ref_clk_freqs[i].freq_hz; i++) {
>    if (ufs_ref_clk_freqs[i].freq_hz == freq)
>      return ufs_ref_clk_freqs[i].val;
> }
>
> return REF_CLK_FREQ_INVAL;
>
> Now it looks like a normal iteration till a normal stop condition
> (NULL term array).
>
Will update.
>> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
> Shouldn't this return an error code so that if there's a problem it
> can return back to the caller?  Right now you print error messages but
> ufshcd_pltfrm_init() will plow merrily along after.
We need not return error if no specific device ref clk was found via DT 
parsing. Device reference clock will be already set(bRefClkFreq MDV : 
26MHz).
So no need to fail if we find invalid/no ref clk passed.
>
>> +{
>> +       struct device *dev = hba->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct clk *refclk = NULL;
>> +       u32 freq = 0;
> "freq" should be "unsigned long" to match clk_get_rate(), not u32.
> Similarly all the places you pass it to and store it in should be
> "unsigned long" too.  Save "u32" for values which are being programmed
> into 32-bit hardware registers.
>
Will update.
>> +       if (!np)
>> +               return;
> You don't need to check for (!np).  If you do clk_get() and there's no
> np you'll get get an error back.  Handle it there.
>
Will update.
>> +
>> +       refclk = of_clk_get_by_name(np, "ref_clk");
>> +       if (!refclk)
>> +               return;
> I can't quickly tell.  Are you intending "ref_clk" to be optional or
> required?  You check against "NULL" and return with no error message,
> so I'm kinda assuming it's optional.  ...but:
Explicit setting of device reference clock is not mandatory. It will be 
already set (MDV: 26Hz).
We first read the current ref clk setting in device and if host is 
passing different (but valid) ref clk freq then we go ahead and update 
it, otherwise we just return.
> 1. of_clk_get_by_name() doesn't return NULL when the clock wasn't
> specified.  It returns "-ENOENT".  That means that (right now) anyone
> who doesn't specify a "ref_clk" will get a crash when you try calling
> clk_get_rate() on the error-code-clk.
>
> 2. It seems like it would be good to add a comment that
> "dev_ref_clk_freq" was already initted to "REF_CLK_FREQ_INVAL in
> ufshcd_alloc_host() to make it obvious how people are working that
> didn't specify "ref_clk".
Will add comment to clarify that dev_ref_clk_freq is default set as 
REF_CLK_FREQ_INVA.
>
> One note is that regardless of whether "ref_clk" is optional or
> required, something about "ref_clk" should be mentioned in
> "Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt" so people
> know that's an important clock name.
>
Will check and add required documentation.
> Yet another note here is that I'm confused why you'd want to use
> of_clk_get_by_name().  Why not use clk_get()?  You've already got the
> "dev" node and clk_get() should be preferred since not everyone uses
> device tree.
Will update.
>
> OK, one last note is that clk_get() could return -EPROBE_DEFER.  In
> such a case you need to basically cancel your whole probe and
> propagate the -EPROBE_DEFER.  Make sure you think about that when
> you're coding things up.
>
>
> OK, I lied about the previous one being the last note.  Why don't you
> just add a bit of code in the ufshcd_init_clocks() loop.  If you
> notice that the clock name is "ref_clk" (similar to how
> __ufshcd_setup_clocks() checks) then you can grab the frequency.  Then
> you can avoid dealing with all my comments above about
> of_clk_get_by_name() and errors and -EPROBE_DEFER...
>
Will consider above suggestion and update.
May be I can just call ufshcd_parse_dev_ref_clk_freq (hba, ref_clk) from 
ufshcd_init_clocks() loop and pass ref_clk to it.
>> +       freq = clk_get_rate(refclk);
>> +
>> +       hba->dev_ref_clk_freq =
>> +               ufs_get_bref_clk_from_hz(freq);
>> +
>> +       if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
>> +               dev_err(hba->dev,
>> +               "%s: invalid ref_clk setting = %d\n",
>> +               __func__, freq);
> nit: including "__func__" in dev_xxx() calls is discouraged.  The
> "dev_xxx" calls already print the device name and the string within a
> given device driver should be unique enough so __func__ just adds crap
> to the logs.  If you really feel that __func__ adds something for you,
> try posting up a patch to make all "dev_err" functions include
> __func__.  ...but I think you'd probably be rejected.
will remove __func__ .
>
> Also (more important): You're missing a clk_put().  Thus you're
> leaking a reference to "ref_clk".
>
>
>> +}
>> +
>> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>> +{
>> +       int err, ref_clk = -1;
>> +       u32 freq = hba->dev_ref_clk_freq;
> Ugh, this is ugly.  hba->dev_ref_clk_freq could be -1 but you're
> jamming it into a u32 here.  That doesn't seem so ideal.  Are you sure
> -1 was the best choice for REF_CLK_FREQ_INVAL?
ufshcd_set_dev_ref_clk() is only called if  (dev_ref_clk_freq != 
REF_CLK_FREQ_INVAL).
So we only set freq if we get a valid parsed ref clk freq (0/1/2/3h).
>
>> +
>> +       err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>> +                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
> It's not so wonderful to be passing a pointer to an "int" to a
> function expecting a pointer to a "u32".  Change "ref_clk" to "u32".
done
>
>> +
>> +       if (err) {
>> +               dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
>> +                        __func__, err);
> Again, no __func__.
>
Will remove __func__
>> +               goto out;
>> +       }
>> +
>> +       if (ref_clk == hba->dev_ref_clk_freq)
> nit: you already cached "hba->dev_ref_clk_freq in "freq".  Use it.
Will update
>
>> +               goto out; /* nothing to update */
>> +
>> +       err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
>> +                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &freq);
>> +
>> +       if (err) {
>> +               dev_err(hba->dev, "%s: bRefClkFreq setting to %u Hz failed\n",
>> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);
> Again, no __func__.
>
Will remove __func__
>> +               goto out;
>> +       }
>> +
>> +       dev_dbg(hba->dev, "%s: bRefClkFreq setting to %u Hz succeeded\n",
>> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);
> Again, no __func__.
Will remove __func__
