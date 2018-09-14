Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0120882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpQYHcbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD0120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeINN4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:56:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43341 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeINN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:56:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id h64-v6so7163367lfi.10;
        Fri, 14 Sep 2018 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8S+bsgps4KU6cS3q5yhTN1++3ctTEKDWeOhugNq9h0Y=;
        b=qpQYHcbJeXfEir43uspSUoju1wpaSw2tMZstic4aZMOWn410QIXtnZfW1AYDMSoQrz
         LTt/HT4WdAZBcjI53G5ZPkdn2uEuseYPY4hJy04uUDYjwM/04eanVFqNwYPlx0Q6dCAP
         RHadfcoqAv6BRmMmf8SYELj45Oz7orNjOh1e1l26gdaUKpvE3zsRuLk7LJW6Na8z5BHY
         +D1lT9oBjo5A40WW9subpiN067q19HOglK68Wswq0nwM1SQycwNhfAaY4YjTFfjj200h
         3qX2v1gUv6LhYDS/g28A10/Fi0dRbmgodfxAXeds1zrKKokN+SOXRT7iSmP9xDwSa9tL
         P8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8S+bsgps4KU6cS3q5yhTN1++3ctTEKDWeOhugNq9h0Y=;
        b=JskJwJyEM73Levr4nto2MG2ptcAEru9gq/TMwhbX3/LcQZxDQiv815uY/gzxJXldRZ
         2d7vOWjWFsWxP6gNwgLG7xITDB1YZrGFAWlqyFcqKU1ts3WrElAUsU/l9l2g2smlCrYW
         NrGsIrGYLL1Vdtggy+XS3woAIoxJS4L2Qs5R0NSbxMYhvSxhyfyBDf4xw74IWGqwj1jy
         zFNPEhQe0/4zp6zifkycH713/a0RdxFKM7/0wZ5psuZR1aK2JQ1oFDOf4UAYoJ7Fa/s+
         mqcY/WfXHkLyo/vTmk91LVfz9PZ2S3M58xYgZAI38DLXu/GYBcEHcBXLKSeIWn7Tr/PD
         QSSQ==
X-Gm-Message-State: APzg51C0nJ6I6j0H807q44hkwlXniUykMEtIFm0mROyI+vqI0lAK9+1s
        yZwrbgE05w0Vik+2s2TjWFgeO5dv
X-Google-Smtp-Source: ANB0VdY2MKRJ9fWuMavHsfTW1ZzdSItcGdEeJYaZhQAF1x3DHFnNXvAlQwo+eyovNWB+paK57hiFyg==
X-Received: by 2002:a19:12a5:: with SMTP id 37-v6mr1690456lfs.51.1536914564008;
        Fri, 14 Sep 2018 01:42:44 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b80-v6sm1184755lfe.83.2018.09.14.01.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 01:42:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0jga-0008F2-6s; Fri, 14 Sep 2018 10:42:44 +0200
Date:   Fri, 14 Sep 2018 10:42:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, dcbw@redhat.com,
        Lars Melin <larsm17@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
Message-ID: <20180914084244.GB1362@localhost>
References: <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
 <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
 <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
 <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
 <87y3c6a1zw.fsf@miraculix.mork.no>
 <20180913091753.GA3443@localhost>
 <CAKfDRXgNxohLv_SzAZ0niv5QreToSotACadTMx_fqSi_ozObvg@mail.gmail.com>
 <20180914075114.GA1362@localhost>
 <CAKfDRXg93B+GZuifG0=rznQJ5G8Zw6GjOwhJunGYTrTKXDHnDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfDRXg93B+GZuifG0=rznQJ5G8Zw6GjOwhJunGYTrTKXDHnDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 09:53:31AM +0200, Kristian Evensen wrote:
> Hi Johan,
> On Fri, Sep 14, 2018 at 9:51 AM Johan Hovold <johan@kernel.org> wrote:
> > Great, thanks for testing. Do you mind if I add your tested-by to the
> > patch?
> 
> Not at all, go right ahead! I should probably have replied to the
> patch with a Tested-by. Sorry about forgetting that.

No problem at all, I've applied these for 4.19-rc now.

Thanks,
Johan
