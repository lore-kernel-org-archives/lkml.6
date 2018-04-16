Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbeDPLiB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:38:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:55431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeDPLiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:38:00 -0400
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [V9fs-developer] [PATCH 2/2] fs/9p: detecting invalid options as
 much as possible
From: cgxu519@gmx.com
In-Reply-To: <20180416075641.GA16402@nautica>
Date: Mon, 16 Apr 2018 19:37:32 +0800
Cc: "cgxu519@gmx.com" <cgxu519@gmx.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <923F6291-1E42-42DF-9312-5720050037E3@gmx.com>
References: <1523864909-4337-1-git-send-email-cgxu519@gmx.com>
 <1523864909-4337-2-git-send-email-cgxu519@gmx.com>
 <20180416075641.GA16402@nautica>
To: Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-Provags-ID: V03:K1:rkbSZH1auPtAf8cVegGhzETJPQaakggWr8D9wbr8ei14pvUbryU
 KKMLspiSBQPQTJdRFwwen23Os0jEzYMB7Kzd9SAzUNujUOZgYXGUM5QzycFUmLJM9lwmZX2
 VN+cTuWWrX5AzL/DiP/ZyVEJVwAOvRMb1A2HDhYF/AvacXKb4d15M1PXrZ7HTvtr+ppmvf/
 /tEcPcZUh3SEhy3U6xDJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qhhNkArSkJw=:hgv1KDkg2oscSaoVLuA8wP
 evLa3svcvcpAK1jZtMI6/ImeyVSVghKqSJjlCXzJha8bgTsml8Ci6YMdTh8w137TADn0mVCae
 MtJtzNrvosnH9Z9nrakyPuVZabqY1su7q9nqEBPgZzi3BLoOytqLP9itEZURbHXdcptPkmDJn
 VUULneD4RqWW0w7NKh/HgshSSsPeN31x45wGtHbl8h3qmWaemV2x7OcfAqVzYGRZtbilPuI92
 8exDTJnxzypyOt4IxPfxmY166ONxXIfd/YpdjcpgwPwwO8nUHCIoWRfjASghDPNCvcFIpLGOC
 32XakzMkoomF80SfUsa5npnP7iT9xh9uDJux7CKtdoy19cnz6S9cqtOa7gx80FW0INAMO6OCV
 LqGzjAdZtyIcKnpAGTLBpVx4YhDYHe4uMbcgyjOEBf58AAhph1vuXHELqQ0YlWljgR/8MsEYV
 huWF3/s1OJPElzQYnpPjPj0QyRhbGGrAmJLXAtg+qtvepk7nQiNb79h+2IeFEPxbWpRNbHWM8
 bN7Q0HwkyytxEcnnWWjXUTAoKONKlWFZiVEcHilh4Q9rhMlztWNJXzKkKePwpxDeI+f0VGosx
 fpLiLe+VmoMYKMjwioaMNYj2WVP4bP7exZHut4tR7c0NTWBqR+qXhXsqrA8w0emWwOuW8yxBG
 FrDiKZTiwg+IWE+uyGF5kw7bE7Z1XE6ckviHMxcjKHuVuRoM/OtXHxZ3sCpUezDMT/4IplRjj
 oo2rb/TK7IrbcuMU6GrqVRb50IUi91iug2bTw45ZM8Fez9m9tEObp2C4ZABjDLbL7gm7oplSg
 uUpW5ROLMqUmwlhG93gKe0O/nw3tjFDOCClcxBY2OMwrBJ6cAE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

Thanks for your quick reply and comment.


在 2018年4月16日，下午3:56，Dominique Martinet <asmadeus@codewreck.org> 写道：
> 
> Chengguang Xu wrote on Mon, Apr 16, 2018:
>> 		default:
>> +			p9_debug(P9_DEBUG_ERROR,
>> +				"unrecognized mount option \"%s\" or missing value\n",
>> +					p);
>> 			continue;
> 
> The problem with that is that the same options are passed to the vfs,
> net and transport init later on - none of which know the full subset of
> valid options to tell what option has been recognized or not.
> 
> Unless we do some backward-incompatible breakage of passing all the
> net/transport options in its own option (e.g. net=foo:bar:moo) there
> unfortunately is no nice way of fixing this now.

Yes, I agree with you.


> 
> 
> (I don't mind the rest of the patches, although I'd say if we hit ENOMEM
> there is likely trouble going on so I'm not so sure about hiding it if
> there also is an EINVAL, but I don't really care)

The initial motivation of hiding ENOMEM here is when reproducing the error，
the error code may change by system condition(more accurately memory condition),
after this patch the error code will be persistent. However, as you pointed out,
when we hit ENOMEM there would be a serious trouble, so in real life maybe we
cannot benefit from it. What do you think? 

Thanks,
Chengguang.
