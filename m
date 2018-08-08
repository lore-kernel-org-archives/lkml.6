Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42175C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687C21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H3MGs8AI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D687C21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeHHMFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:05:49 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com ([40.107.8.93]:33575
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHHMFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4Q0X6BD02QRMjMXQj+vnCMcJmNOLeFGY9NIX7scrJo=;
 b=H3MGs8AIU5Mel3nA4MoLRGBqrCk8beUX+Ax2byQ5JplY0K1V4lQh0BjCFkkLsVn0HFb8AU6bwe4i+sO1p0KOFDpWAdkYL0jHsN6dPd9zoXZQVq9wXlh2cHZ/FUqrC2Vxc1ev6e4RAnCUkuoHiwKfVTShkNwAwQdBSpJfVjH9lrQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 8 Aug 2018 09:46:45 +0000
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, vdavydov.dev@gmail.com,
        mhocko@suse.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808110542.6df3f48f@canb.auug.org.au>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a1ca4c67-aa03-7381-151e-e7d85e402e78@virtuozzo.com>
Date:   Wed, 8 Aug 2018 12:46:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808110542.6df3f48f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0701CA0021.eurprd07.prod.outlook.com
 (2603:10a6:203:51::31) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac2b8ee-a5a0-4646-c83c-08d5fd13dc33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:gkXSR73I9/+XntIFGbdNdAcL/p+Qit3s9iSiWLmasikw/HNczqlC2Wr/VO6PXiq73OTnXll/QUjfK4TnJB1DWu9dFLcMBK1gemWs5H9beqT2tqW8xWSuZPAo2AnxNuXobCxj4+MgNUvl/m5EwHUvxqqo3MiBInAkUqaP6OHL8Ui9nARS2iaM96KhfGUIfwwUOc5EwJ9cW+T7wqLp3YLtLrdH4MLYj9ICLQHlv4KMdaOJp7tNCH+qS1/DecW6Sikg;25:3LzRnakZGp6qaRaHp0Ct8Imj1sUE9K/h4I4byMTQKiJi85cbSBAq6CE4vINGzsGUWvs1F3IMOsCN8Y53H42r7UUG5xmnPvTv0bAaOF5nV46zpXWFe8RPB5sm60kDNFAcTie6kMIQtkt3kJ50PSpg5H2zokKuD/EpCIWO8+mMsOWbgGzib1JLVF9Ki/c3WFqHqiohq9EdzlWYiCOh9M63rqHYDVgox5Cz3UlTBbCpnLCd2ODDHUm5O0bkttHDxFj3K++rgr9aQbjVNfxJxqlicec62a9kQd42dMOjqXEIihF0HJmjd6a/O7jY82Vm1Ee7YpvEnhZuly5X2uWLcrbAIA==;31:9s+jTzYsLIdQbdeaAE39d6vwltpbc/cq6gALrE6GVINzYP0i94SW8bMuU05uHdAfUONflRqtk5QcDRuCchsIHVwXvWd9DN6+WzuAyxOr/ELyoHKII0xl4RYWdmnb6KpsJ1GYkVcccXyiUHIkRJlbSDBnjF4sIVTn2tfOzcREjW3haFmMVrDUDHmexrbRd93b5hykM5T10RhmvyofgQO//UKpsdUfrZPW0CBt1C2Et44=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:rAZExKUX3WF6F6CmlXPqKfP0X7eRBBSvV9g3pWxGBvj4iouzzTQQPffmQmdPHMGBUP6MJPhsGHiEPfjLhKAzcnRgqhnxl6gAKIxaN5Tpt0Cf5Uqn1ZOpcY7qtAGVexvZkvEcKvKphRKfcKlFtiCKbumvvkysMiNkUCjQXEit01ck3yOvTVALCHRmAseoK5M6JVfx8WcJWIFOwmWfZyA71HWr6HyJp9J8gt0t/T5IGtXLkD6qYtgFuPR4Cqq8He438I5urW7Du0gdSxgB/RYdlg/sKIIb9YhjIqLzACNcLA4Br+pNvkq+2qirBKY0E6DcbEK6SOxl6ic1CK5JUTDL3iL/jqStNSisj7BsX+qhpmZHXXhudwHuyCOAdI/wb8D2b6plUM2cIN5DsV7FslwB7e/ukxpU7xgthbQhafgTzlRZXlx9DyuM6PyV3FtE4tU/Kn7yzgp/lj4vchHJihVzux19fIqzlqh6MyP/teDSrKOFiDwSIpkMTllbvqXbcA7S;4:CQsI1EoX+DPU6TByj1EyM7tMgSIBcJzRnzycfKKQGQxOfS6XoU1zcjp11Tgpccfu42MmQzLHZ1Kg8OatSMzAhrnZNl6iA9tQ6Z79qfwE+mxG608iEeKKU0TpChvWv4y/GBk8ABUeDVywcsJMpuAZmOJ/3MDwsBxXXfDxj/YseIY0GLTnl1HkqPEeJG9TBPPa1tBkqoxCOEAfROBCRnaoHuKJ7OPcUU1d8aO28pwuQ2+OpPBkMY2I7sk4z8kt0RLB6vgmrl8gx2u0D2XU+wRVWQmIdKcWd08gtYfE0u9BY38SHR9vkH7I3HbZwf3yOD04
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2024DF5E4C662FD6CC103D62CD260@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(366004)(39840400004)(376002)(396003)(199004)(189003)(2906002)(7406005)(66066001)(65806001)(65956001)(7416002)(217873002)(64126003)(81156014)(68736007)(8676002)(14444005)(8936002)(47776003)(106356001)(25786009)(105586002)(81166006)(3846002)(6116002)(31686004)(305945005)(229853002)(86362001)(23746002)(4326008)(7736002)(6916009)(6666003)(31696002)(230700001)(16526019)(53546011)(26005)(36756003)(16576012)(316002)(77096007)(76176011)(386003)(52116002)(58126008)(478600001)(956004)(11346002)(486006)(2616005)(6486002)(446003)(476003)(53936002)(186003)(39060400002)(97736004)(5660300001)(65826007)(6246003)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DB6PR0801MB2024;23:3/eRoB1/gecopF76/9KQXkCt6Ib4anC1a2Y?=
 =?Windows-1252?Q?iK+Y+jLUxpq8X0n6APHBLC55GqJsL+L+4h8wqKSPD9Q7p4jzjxDx5fxg?=
 =?Windows-1252?Q?tGJl+XCcxJtD9t+fYh1/RQE/o1MTBlPCiAvzBvb3LeuSozv9wJR0xC8h?=
 =?Windows-1252?Q?Jsnz4kwOVgFk1uKSp79cSDowadLA90NX7+mSU1oFzDMS02DnTgzXI0Rh?=
 =?Windows-1252?Q?8YUhHtdBff0ar5MMyp5vZ9xGxPp/c1XAnRQT3SB8ncZ9ibWB4Y8JvpEC?=
 =?Windows-1252?Q?YWJ7K4JN1BY7BdEh7+/CoQ4m8i/EMbVwpXP5OW157CNCREpuVkjy5OTR?=
 =?Windows-1252?Q?8t7ByORjuOgSBeMRob8KFLJtYIWWiv72VzEorFHjBnJOl+HziAPRqDGd?=
 =?Windows-1252?Q?uJ7SZqcxohfViEBVNpas/ZnqguCnoagPSzTOLazGKN2JpHLDGTil1je7?=
 =?Windows-1252?Q?RpaW2FCu77bSLTgaqeHuuripFxvqEvRzMelpODSepBxQ2biOk/oX4UY8?=
 =?Windows-1252?Q?8eazLhS/qg2JH6Mn7E+/0vZPlhuAsGuntmmkB9XnKLWHAOcQFAKjBSfQ?=
 =?Windows-1252?Q?WhTYjhIrPXftN1p713PtYAYgYjt+DLJghyg7AxZLN3m0dXPRvTRXAmBL?=
 =?Windows-1252?Q?fd8kRidZwOTP5a8t8gbPWP5WlmiblKe7lQCi0YnSqod4sfoXqE2txTMn?=
 =?Windows-1252?Q?507bqCpdvc/Z/DnE/o5wi+YGDOjKjzsC40pBAMQjQ1QOxJVOXmfVdyRX?=
 =?Windows-1252?Q?H4LXcgbPzjHTe7G9SNWz25C+h7bJGFgq+dwlBNiUEIgOexhycdI+G/2L?=
 =?Windows-1252?Q?G2OQ25LSNnobWMpnncVPvs5bxTTuAmuuhAqu4G2RLKJN9tTzMltnsVZY?=
 =?Windows-1252?Q?TEi4CvVjIiwflDoHWb6mM5DctEdICcRNoBQds+l2bdij9IBbUfVnBlAW?=
 =?Windows-1252?Q?mLUvPQnpEHAvkjY56dJZNFsF2NBk+MvTrIMDgF5i/e4l+786kqjKshQX?=
 =?Windows-1252?Q?9dqb6tL45mgr8pUSBP+f5lZAslZ0d7PhuUGSxHWLLaQrsgTg5bZCeLl1?=
 =?Windows-1252?Q?Nk6MbndpfQmzgHS5G6zoiBvkNzYiZfhAlnmukjJzgOqHxGeN868FAN+k?=
 =?Windows-1252?Q?+oHkvO3p298W0lRs5mRvFF84Nf9uVKhpP/CXupO5pscKRsgpZxX80MvG?=
 =?Windows-1252?Q?gtykrHVPCkUJgbeV6zfsPRzGzUsnmF19zK3Ij8WanJD37q9KIOe3ZJdO?=
 =?Windows-1252?Q?pgk2BAQvQ0nwWB6wauc7TNBrQY0IqDGws/mUeP/dXEEk4BVi8ju7DfDs?=
 =?Windows-1252?Q?YdXSTtrMyvIB6yePY3tjOJ14qM7crhGtbc8CgJWK7ad0eUSCHrAwwARt?=
 =?Windows-1252?Q?itpnGP3jykkGgFnALQn2N3pNeWV2FSW7XDduFbDfQ4DiSMKwh8XqTFnD?=
 =?Windows-1252?Q?Ftho3gcbq4+b28Qxs4Z/iftQ6wMoBxsR2vdTK90wqbfnuqwPChNTLf8S?=
 =?Windows-1252?Q?yujVXJd3mDRBynknQB9o6xwiVw6kEOhUrgNdm+tLeUW80d3koQtUy+FT?=
 =?Windows-1252?Q?ZVmK0RBjBoP9TjdcHnTAmVyKoGQATiPfmTBNj?=
X-Microsoft-Antispam-Message-Info: xV48Nh+PF7Zh3rsH+VDmhX9LVtClk+OVSTPVgCaXQDYqXPjyLt3tOCNFpgx7hcEsx+37XNIkce++20eqlBG2jnhSozo1oIzFhUqhS5hAzbA1FvLb0L7wHx79a4DFNXxGXvPvh6bWr/c00KV71C+FulgQc3xX2ji2hl/r6L0nZsVKGFj8bo5bd1HAUSdWPuTdUFZ3fZ9apTwTVUp3RPaI4KNHg0T9fbhfq/Me2oXyrvWtxYzgS4L0kEXlBsqOoJpXjNzVxn4Gk9oRwG4Ts5j6oIodn08iQd768tRJLGlzmC8OI8mPVCaly/3AENshiz7ZMj1lrL9fUo1MGiuF1PqYaycfdWVkPuYJ3ZDavCigseg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:HmJybEC0Bc4qS9xLqF7RNYiQOyIoLsxmNcFsEcuhnv2J6oKUdYPd4ASUcnBQO0zHcR8OXZZASDpfIn4EURNwiDUhGxj+eVYQ5Y7X9AO+zwoTkQxXFXcTwQXs0yKwsB2VOrZPeV5+UuH6ZRLRJYwnWMBxTxLw1bV5XVRxpn8p+TzAEjnn9kyp4YK3wJCidNTvGl0KopqD0GzYsnDxPXzwg5gjYLjARq/YLHf4pJkndzD+I01e/FbR+Za2LUnEu7U/DSt4E61EPvFJe6x9hC4xoq+9A7DSvN046OTh83sPGR5KBYWbYoiMVGDUpevtDufQOOq9o8gfrYDROIXL1upMMAaspL3+U7b0jmP3u+5h9Gf8BJhZxcV3uKHtxvj/G5lreoJ3/IAgu2oXm3Ge+ULerx2xH2z0oKjK0Dccwv8svz10ooyzSNEF3EuCVTGvvdK+iwHFgiCAsqADxqM5f66C5w==;5:5xWjWt6WH2MDcjy8mV4kBs2Mhpzsoe9AJi2pD0v8HfD+e1VaiuesmGIEfogiNKoOoa6XcA/Kxet4XTH1h+rgVLUMKunqqne/N9jxr67XWaUuACMXNzaZijsEWsKejT/1kBYiu+np1HqvXCFwm2cG4EAtol1Ltzr24jm7lOswaUc=;7:86Rs7XDoyoawsAwJX++F8LKJLSKLzJYkgPsukmObu3cy59eEEkP82RACOyX2GQ9n97dcProZQ+lO1hrdUbfpcR1QlHygm88Q7QqgaAxxMIXUrGseJcNdF/A4PXui4vYScnARXQvrL8CH1bDeLfz7oj8WAlTHJRnL/s/jaEWf1dRP1EjvO1rvcCqmIjyxBApgmcR1Ni8Vicr+6w8W5OwMdP56V2h92ZOQdt5uQP4pvnXKJ1oHf2WqFmEdLTzisZ9Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:C+aYjh+a/Ohcy4W1NSZ4DJwfVK0bdr6M+3ro4pZop1SNiMt0SH7EcXQM30CJBhCkpD18NQuo/Zg9zu00DxLInUspKPP+PdpAGYG1ik19ZWaTOgy0yhSNSusd0ljCkV8XXxZj8KWW+dXjHdKyNJeNvVvnVB/I23QUNniy8meW2po=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 09:46:45.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac2b8ee-a5a0-4646-c83c-08d5fd13dc33
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 04:05, Stephen Rothwell wrote:
> Hi Kirill,
> 
> On Tue, 07 Aug 2018 18:37:36 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> This patch kills all CONFIG_SRCU defines and
>> the code under !CONFIG_SRCU.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  drivers/base/core.c                                |   42 --------------------
>>  include/linux/device.h                             |    2 -
>>  include/linux/rcutiny.h                            |    4 --
>>  include/linux/srcu.h                               |    5 --
>>  kernel/notifier.c                                  |    3 -
>>  kernel/rcu/Kconfig                                 |   12 +-----
>>  kernel/rcu/tree.h                                  |    5 --
>>  kernel/rcu/update.c                                |    4 --
>>  .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    5 --
>>  9 files changed, 3 insertions(+), 79 deletions(-)
> 
> You left quite a few "select SRCU" statements scattered across Kconfig
> files:
> 
> $ git grep -l 'select SRCU' '*Kconfig*'
> arch/arm/kvm/Kconfig
> arch/arm64/kvm/Kconfig
> arch/mips/kvm/Kconfig
> arch/powerpc/kvm/Kconfig
> arch/s390/kvm/Kconfig
> arch/x86/Kconfig
> arch/x86/kvm/Kconfig
> block/Kconfig
> drivers/clk/Kconfig
> drivers/cpufreq/Kconfig
> drivers/dax/Kconfig
> drivers/devfreq/Kconfig
> drivers/hwtracing/stm/Kconfig
> drivers/md/Kconfig
> drivers/net/Kconfig
> drivers/opp/Kconfig
> fs/btrfs/Kconfig
> fs/notify/Kconfig
> fs/quota/Kconfig
> init/Kconfig
> kernel/rcu/Kconfig
> kernel/rcu/Kconfig.debug
> mm/Kconfig
> security/tomoyo/Kconfig

Yeah, thanks, Stephen.
