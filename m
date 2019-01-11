Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD6F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwqLF1XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfAKBFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:05:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46244 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAKBFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:05:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so5951364ply.13;
        Thu, 10 Jan 2019 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fB2hJP/xSQK32eL1DvTMTTE0TsTmVKmT+UznK7gNy2U=;
        b=WwqLF1XSi+VUGOMM07aBjhWGESjZHyXztV4H/7uMIwImXdK+AYHOajE+HNkVxUftT+
         8DfEv3Ba3mPZ+YXk3aBnB18eNTwsPpY3Mg/KgpQFCqKey90k9BMi1G/GBKkQGusCtT16
         EDB3eLUUX9PnqZiMP1Hmtp5VR9UqNKsuNinOUToFCl7zxjOE1BdDZy4CbcljE6X3UE43
         r4YdWcqGNsffnXY8T1GUPRfsPR1I/0wwm75MJSiCOUaaCgso+1SjSO94wxxStaRhG32/
         RaLzmTklnAANnfWOB1Fhv2GdgxyuCTrkKK0lAhDRr+SqThyk1AbonRMVTSmXzjffChWC
         6j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fB2hJP/xSQK32eL1DvTMTTE0TsTmVKmT+UznK7gNy2U=;
        b=LzYlu/SWLGAfK6cldO+Su4aAWFtWH5E/FaBdJcOYFYKzt6JF+7gl9YVfTx1zgJi0Ub
         7emBsoRqnykd1Nft3+3v4jHW7KdtuqNEsVn8rO+fO72bimH8zqZ+f7xXOY7JflHn/G48
         w9Ds4ZJlQMeSBi1YcAIUBq6G/VX1CJKSt3yp2ZK4sz83/7zjmA5rqAp8bjQbcmpdQyRH
         mTX7uNfnGHlLxH39JdHArYiyH0kh7/GWdmhpNdAXvZsbF/qb2xPRFsKOT38tBTtHv8hu
         TECLq0S8evN/jHzPogY05B64KjIoIDTOu0O6gwky+bao3HfVU2XPqIyvCSXt8KphlMUL
         McPw==
X-Gm-Message-State: AJcUukcCjiV0cpOfi3Ew6TX7aHZYo7PI2YpFM8bH0llX/gR1bD01y3/J
        ofvVFbKX32kVJmBoz/g9+Bw=
X-Google-Smtp-Source: ALg8bN54mOtEC33zSTXmgul2NT3Zm+4+GoUoWBENXtJZiQTyEsGyiJ3Bq5MXQOuzHXrd14B04Esoqg==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr12104999plr.221.1547168741765;
        Thu, 10 Jan 2019 17:05:41 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:f849:e85a:90:6d6a? ([2601:282:800:fd80:f849:e85a:90:6d6a])
        by smtp.googlemail.com with ESMTPSA id a90sm138701421pfj.109.2019.01.10.17.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 17:05:40 -0800 (PST)
Subject: Re: [PATCH v6 perf, bpf-next 1/7] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
To:     Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20190109192111.130995-1-songliubraving@fb.com>
 <20190109192111.130995-2-songliubraving@fb.com>
 <20190110182403.GN22483@kernel.org>
 <064FBBA4-A0D0-4335-BCE7-902724CE2988@fb.com>
 <20190110185524.GO22483@kernel.org>
 <CCB26BF8-9FF5-4BBF-84BE-878CF0D3882A@fb.com>
 <E220DFC6-A2E2-4B3A-B52B-3B194315D2A0@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <af9bfba0-6115-922e-f988-fe4aa6bf1ca3@gmail.com>
Date:   Thu, 10 Jan 2019 18:05:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <E220DFC6-A2E2-4B3A-B52B-3B194315D2A0@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 12:45 PM, Song Liu wrote:
> Could you please share your feedback on PERF_RECORD_BPF_EVENT for auditing
> use cases?

Google shows Daniel was the one looking at audit use cases:
https://www.mail-archive.com/netdev@vger.kernel.org/msg250728.html


My comment was that using a PERF_RECORD_BPF_EVENT limits the usability
with combinations of other tracepoints (e.g, scheduling) when tracing
processes.
