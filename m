Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29DC20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deeKxjEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29DC20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbeHPGmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:42:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36982 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHPGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:42:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so1384429pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 20:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XcnifG+Aq4PVXrLP81MlVbvXmz4YxKjEA1FGMR1iJ6Y=;
        b=deeKxjEaWY8fb8zLd9UMEkSx/AGwK9l69oVBIfkdz1zJTStjBMahLXrskco2coGDuk
         xRYu6RZNY0n96B9AqqxrwAl0mHv8kw6KPibqMmDwPVNd2zCvHwVXNK9i+ceVxRM46xZV
         jSu46UoMHyR2L0cx+DzGG93htsHNPuaVF6J1CASEy23tH7YfDK5NmmKRxepIqLdUhX+7
         TC/TlSIjGqnVlSldOEL+6L/lhrpOKEe9fz+iRQA0cUI15k/kXY4IdMEGe5YxpXlnlr4p
         nY4o0iI1AJusOASLhxYGwJ+d11iWjRICnNWUjgiudrFmZLi3eGoDfeTseJ27RQRb45KR
         U/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XcnifG+Aq4PVXrLP81MlVbvXmz4YxKjEA1FGMR1iJ6Y=;
        b=O4bRqLlht+kSJJUbGnxmZCtrA+B/OtpITaLIcG0o5OnVTGkhLaAs7VR8tbvJSIFPn5
         k3qkf3eVT2yaqAwG7M5nMQYheMkJWvUr/FZhkFcvrEMl+QpBG+ci7t57gBN+YCeXWE8a
         TRNyVFdoSw2cwLn+4B038HeFPi4A0AagPkv7f88Y4IjqR1BD8R7aSQ7SbO0ZYJ1GIRo9
         T+PlthhvaAoDA/Jj8AgQeFVn/WtS5nlbcKY4q0mELMTv1V+K/y5tOjKVAsXElof8/eJS
         yWNncsAyWjJ388ItBoBg7wjUpufAyr/8o2VK2TGx6lphxmZYiz7VZoB756u18av6lJej
         SSTg==
X-Gm-Message-State: AOUpUlF1pK3tTXBMzW695R0hukF9tF0cWka9u7rFnEvR5F4t+cqW58Y5
        kc/hhIa4q9XY8n925/DnOPs=
X-Google-Smtp-Source: AA+uWPyPqqFS46Tnb+gskhXA0BLvtuZOq6Pvfm8KedLyoVhov30DBC+vz/4hazVrOh5VvChDZh0bzQ==
X-Received: by 2002:a63:5866:: with SMTP id i38-v6mr27439599pgm.63.1534391208573;
        Wed, 15 Aug 2018 20:46:48 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id e126-v6sm52814116pfg.31.2018.08.15.20.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 20:46:46 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:46:42 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     zhouxianrong <zhouxianrong@tom.com>
Cc:     sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        zhouxianrong@huawei.com, vbabka@suse.cz, yudongbin@hisilicon.com
Subject: Re: Re: [PATCH] zsmalloc: fix linking bug in init_zspage
Message-ID: <20180816034642.GA62516@rodete-desktop-imager.corp.google.com>
References: <20180810002817.2667-1-zhouxianrong@tom.com>
 <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
 <20180813105536.GA435@jagdpanzerIV>
 <20180814002416.GA34280@rodete-desktop-imager.corp.google.com>
 <1784999539.213028.1534378242020.JavaMail.root@rz-web2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1784999539.213028.1534378242020.JavaMail.root@rz-web2>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhouxianrong,

Please could you be more sepcific what case can we encounter below BUG?
(Please use plain text)
What zs_class size did you this this problem?
Could you say how that can happen?

As I wrote in other reply, zsmalloc should never allocate last parital
object when I look at source code so we need to understand what specific
case we are missing if it's a real zsmalloc bug.

Please explain how that can be happen with a real example.

Thanks.

On Thu, Aug 16, 2018 at 08:10:42AM +0800, zhouxianrong wrote:
> H<span labeltype=3D"transpond"><minchan kernel=3D"" org=3D"">i:<br /><br =
/>&nbsp; I am sorry so later for replying this message due to something.<br=
 /><br />This is the backtrace edited by me we met.<br /><br />[pid:3471,cp=
u4,thread-3]------------[ cut here ]------------<br />[pid:3471,cpu4,thread=
-3]kernel bug at ../../../../../../mm/zsmalloc.c:1455!<br />[pid:3471,cpu4,=
thread-3]internal error: oops - bug: 0 [#1] preempt smp<br />[pid:3471,cpu4=
,thread-3]modules linked in:<br />[pid:3471,cpu4,thread-3]cpu: 4 pid: 3471 =
comm: thread-3 tainted: g&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; w&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.9.84 #1<br />[pid:3471,cpu4,thread-3]tgid:=
 715 comm: proc-a<br />[pid:3471,cpu4,thread-3]task: ffffffcc83ba1d00 task.=
stack: ffffffcad99b0000<br />[pid:3471,cpu4,thread-3]pc is at zs_map_object=
+0x1e0/0x1f0<br />[pid:3471,cpu4,thread-3]lr is at zs_map_object+0x9c/0x1f0=
<br />[pid:3471,cpu4,thread-3]pc : [] lr : [] pstate: 20000145<br />[pid:34=
71,cpu4,thread-3]sp : ffffffcad99b3530<br />[pid:3471,cpu4,thread-3]x29: ff=
ffffcad99b3530 x28: ffffffcc97533c40<br />[pid:3471,cpu4,thread-3]x27: ffff=
ffcc974dd720 x26: ffffffcad99b0000<br />[pid:3471,cpu4,thread-3]x25: 000000=
0001fa9f80 x24: 0000000000000002<br />[pid:3471,cpu4,thread-3]x23: ffffff89=
c3a27000 x22: ffffff89c30e6000<br />[pid:3471,cpu4,thread-3]x21: ffffff89c3=
54f000 x20: ffffff89c3234720<br />[pid:3471,cpu4,thread-3]x19: 000000000000=
0f90 x18: 0000000000000008<br />[pid:3471,cpu4,thread-3]x17: 00000000bbb877=
ff x16: 00000000ffdba560<br />[pid:3471,cpu4,thread-3]x15: ffffffcaeab13ff5=
 x14: 000000009e3779b1<br />[pid:3471,cpu4,thread-3]x13: 0000000000000ff4 x=
12: ffffffcaeab13fd9<br />[pid:3471,cpu4,thread-3]x11: ffffffcaeab13ffa x10=
: ffffffcaeab13ff8<br />[pid:3471,cpu4,thread-3]x9 : ffffffca8cc201b8 x8 : =
ffffffca8cc20190<br />[pid:3471,cpu4,thread-3]x7 : 000000000000008e x6 : 00=
0000000000009b<br />[pid:3471,cpu4,thread-3]x5 : 0000000000000000 x4 : 0000=
000000000001<br />[pid:3471,cpu4,thread-3]x3 : 00000042d42a9000 x2 : 000000=
00000009d0<br />[pid:3471,cpu4,thread-3]x1 : ffffffcc994ddbc0 x0 : 00000000=
00000000<br /><br />[pid:3471,cpu4,thread-3] zs_map_object+0x1e0/0x1f0<br /=
>[pid:3471,cpu4,thread-3] zs_zpool_map+0x44/0x54<br />[pid:3471,cpu4,thread=
-3] zpool_map_handle+0x44/0x58<br />[pid:3471,cpu4,thread-3] zram_bvec_writ=
e+0x22c/0x76c<br />[pid:3471,cpu4,thread-3] zram_bvec_rw+0x288/0x488<br />[=
pid:3471,cpu4,thread-3] zram_rw_page+0x124/0x1a4<br />[pid:3471,cpu4,thread=
-3] bdev_write_page+0x8c/0xd8<br />[pid:3471,cpu4,thread-3] __swap_writepag=
e+0x1c0/0x3a8<br />[pid:3471,cpu4,thread-3] swap_writepage+0x3c/0x64<br />[=
pid:3471,cpu4,thread-3] shrink_page_list+0x844/0xd84<br />[pid:3471,cpu4,th=
read-3] reclaim_pages_from_list+0xf4/0x1bc<br />[pid:3471,cpu4,thread-3] re=
claim_pte_range+0x208/0x2a0<br />[pid:3471,cpu4,thread-3] walk_pgd_range+0x=
e8/0x238<br />[pid:3471,cpu4,thread-3] walk_page_range+0x7c/0x164<br />[pid=
:3471,cpu4,thread-3] reclaim_write+0x208/0x608<br />[pid:3471,cpu4,thread-3=
] __vfs_write+0x50/0x88<br />[pid:3471,cpu4,thread-3] vfs_write+0xbc/0x2b0<=
br />[pid:3471,cpu4,thread-3] sys_write+0x60/0xc4<br />[pid:3471,cpu4,threa=
d-3] el0_svc_naked+0x34/0x38<br />[pid:3471,cpu4,thread-3]code: 17ffffdd d4=
210000 97ffff1f 97ffff83 (d4210000)<br />[pid:3471,cpu4,thread-3]---[ end t=
race 652caafc4c4b6d06 ]--- <br /></minchan></span><blockquote style=3D"padd=
ing-left:1ex;margin:0px 0px 0px 0.8ex;border-left:#ccc 1px solid"><pre>Hi S=
ergey,
>=20
> On Mon, Aug 13, 2018 at 07:55:36PM +0900, Sergey Senozhatsky wrote:
> &gt; On (08/13/18 15:05), Minchan Kim wrote:
> &gt; &gt; &gt; From: zhouxianrong <zhouxianrong huawei=3D"" com=3D"">
> &gt; &gt; &gt;=20
> &gt; &gt; &gt; The last partial object in last subpage of zspage should n=
ot be linked
> &gt; &gt; &gt; in allocation list. Otherwise it could trigger BUG_ON expl=
icitly at
> &gt; &gt; &gt; function zs_map_object. But it happened rarely.
> &gt; &gt;=20
> &gt; &gt; Could you be more specific? What case did you see the problem?
> &gt; &gt; Is it a real problem or one founded by review?
> &gt; [..]
> &gt; &gt; &gt; Signed-off-by: zhouxianrong <zhouxianrong huawei=3D"" com=
=3D"">
> &gt; &gt; &gt; ---
> &gt; &gt; &gt;  mm/zsmalloc.c | 2 ++
> &gt; &gt; &gt;  1 file changed, 2 insertions(+)
> &gt; &gt; &gt;=20
> &gt; &gt; &gt; diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> &gt; &gt; &gt; index 8d87e973a4f5..24dd8da0aa59 100644
> &gt; &gt; &gt; --- a/mm/zsmalloc.c
> &gt; &gt; &gt; +++ b/mm/zsmalloc.c
> &gt; &gt; &gt; @@ -1040,6 +1040,8 @@ static void init_zspage(struct size_=
class *class, struct zspage *zspage)
> &gt; &gt; &gt;  			 * Reset OBJ_TAG_BITS bit to last link to tell
> &gt; &gt; &gt;  			 * whether it's allocated object or not.
> &gt; &gt; &gt;  			 */
> &gt; &gt; &gt; +			if (off &gt; PAGE_SIZE)
> &gt; &gt; &gt; +				link -=3D class-&gt;size / sizeof(*link);
> &gt; &gt; &gt;  			link-&gt;next =3D -1UL &lt;&lt; OBJ_TAG_BITS;
> &gt; &gt; &gt;  		}
> &gt; &gt; &gt;  		kunmap_atomic(vaddr);
> &gt;=20
> &gt; Hmm. This can be a real issue. Unless I'm missing something.
> &gt;=20
> &gt; So... I might be wrong, but the way I see the bug report is:
> &gt;=20
> &gt; When we link objects during zspage init, we do the following:
> &gt;=20
> &gt; 	while ((off +=3D class-&gt;size) &lt; PAGE_SIZE) {
> &gt; 		link-&gt;next =3D freeobj++ &lt;&lt; OBJ_TAG_BITS;
> &gt; 		link +=3D class-&gt;size / sizeof(*link);
> &gt; 	}
> &gt;=20
> &gt; Note that we increment the link first, link +=3D class-&gt;size / si=
zeof(*link),
> &gt; and check for the offset only afterwards. So by the time we break ou=
t of
> &gt; the while-loop the link *might* point to the partial object which st=
arts at
> &gt; the last page of zspage, but *never* ends, because we don't have nex=
t_page
> &gt; in current zspage. So that's why that object should not be linked in,
> &gt; because it's not a valid allocates object - we simply don't have spa=
ce
> &gt; for it anymore.
> &gt;=20
> &gt; zspage [      page 1     ][      page 2      ]
> &gt;         ...............................link
> &gt; 	                                   [..###]
> &gt;=20
> &gt; therefore the last object must be &quot;link - 1&quot; for such case=
s.
> &gt;=20
> &gt; I think, the following change can also do the trick:
> &gt;=20
> &gt; 	while ((off + class-&gt;size) &lt; PAGE_SIZE) {
> &gt; 		link-&gt;next =3D freeobj++ &lt;&lt; OBJ_TAG_BITS;
> &gt; 		link +=3D class-&gt;size / sizeof(*link);
> &gt; 		off +=3D class-&gt;size;
> &gt; 	}
> &gt;=20
> &gt; Once again, I might be wrong on this.
> &gt; Any thoughts?
>=20
> If we want a refactoring, I'm not against but description said it tiggered
> BUG_ON on zs_map_object rarely. That means it should be stable material
> and need more description to understand. Please be more specific with
> some example. The reason I'm hesitating is zsmalloc moves ZS_FULL group
> when the zspage-&gt;inuse is equal to class-&gt;objs_per_zspage so I thou=
ght
> it shouldn't allocate last partial object.
>=20
> Thanks.
> </zhouxianrong></zhouxianrong></pre></blockquote><div style=3D"height:30p=
x;"></div><div style=3D"height:2px;width:298px;border-bottom:solid 2px #e5e=
5e5"></div><div style=3D"height:20px;"></div><a target=3D"_blank" style=3D"=
background-image:url(http://r.g.tom.com/kwap/r/app/other/suixinyou.png);bac=
kground-repeat:no-repeat;background-position:left center;font-size:14px;bac=
kground-size: 20px;height: 39px;line-height: 39px;padding-left: 25px;displa=
y:block;color:#333333;text-decoration: none;" href=3D"http://mail.tom.com/w=
ebmail-static/welcomesxy.html"  onmouseover=3D"this.style.cssText=3D'backgr=
ound-image:url(http://r.g.tom.com/kwap/r/app/other/suixinyou.png);backgroun=
d-repeat:no-repeat;background-position:left center;font-size:14px;backgroun=
d-size: 20px;height: 39px;line-height: 39px;padding-left: 27px;display:bloc=
k;color:#4c4c4c; text-decoration:underline;'" onmouseout=3D"this.style.cssT=
ext=3D'background-image:url(http://r.g.tom.com/kwap/r/app/other/suixinyou.p=
ng);background-repeat:no-repeat;background-position:left center;font-size:1=
4px;background-size: 20px;height: 39px;line-height: 39px;padding-left: 27px=
;display:block;color:#4c4c4c;text-decoration:none'">=E9=9A=8F=E5=BF=83=E9=
=82=AE-=E5=9C=A8=E5=BE=AE=E4=BF=A1=E9=87=8C=E6=94=B6=E5=8F=91=E9=82=AE=E4=
=BB=B6=EF=BC=8C=E5=8F=8A=E6=97=B6=E7=9C=81=E7=94=B5=E5=8F=88=E5=AE=89=E5=BF=
=83</a>

