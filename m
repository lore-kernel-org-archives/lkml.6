Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeFDE6X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 00:58:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751061AbeFDE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 00:58:22 -0400
Date: Mon, 4 Jun 2018 07:58:12 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
 <20180603124941.GA29497@rapoport-lnx>
 <CAHCio2ifo3SNH9E3GX2=q1a=MNiNnoCu+2a++yX5_xMBheya5g@mail.gmail.com>
 <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2in8NXZRanE9MS0VsSZxKaSvTy96TF59hODoNCxuQTz5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060404-0028-0000-0000-000002CC5750
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060404-0029-0000-0000-00002382DA2A
Message-Id: <20180604045812.GA15196@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040061
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:41:10AM +0800, 禹舟键 wrote:
> Hi Tetsuo
> > Since origin_memcg_name is printed for both memcg OOM and !memcg OOM, it is strange that origin_memcg_name is updated only when memcg != NULL. Have you really tested !memcg OOM case?
> 
> if memcg == NULL , origin_memcg_name will also be NULL, so the length
> of it is 0. origin_memcg_name will be "(null)". I've tested !memcg OOM
> case with CONFIG_MEMCG and !CONFIG_MEMCG, and found nothing wrong.
> 
> Thanks
> Wind
> 禹舟键 <ufo19890607@gmail.com> 于2018年6月4日周一 上午9:58写道：
> >
> > Hi Mike
> > > Please keep the brief description of the function actually brief and move the detailed explanation after the parameters description.
> > Thanks for your advice.
> >
> > > The allocation constraint is detected by the dump_header() callers, why not just use it here?
> > David suggest that constraint need to be printed in the oom report, so
> > I add the enum variable in this function.

My question was why do you call to alloc_constrained in the dump_header()
function rather than pass the constraint that was detected a bit earlier to
that function? 

Sorry if wasn't clear enough.

> > Thanks
> > Wind
> 

-- 
Sincerely yours,
Mike.
