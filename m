Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeAaJNs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:13:48 -0500
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:63616
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751320AbeAaJNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:13:42 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <jg@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Topic: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Index: AQHTmjgzfFIfrni0bUC6szzPt5VlUKONrQcAgAAGGcM=
Date: Wed, 31 Jan 2018 09:13:39 +0000
Message-ID: <F1AA3AA6-8F23-43A8-9C4C-5F684A80782C@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-5-git-send-email-javier@cnexlabs.com>,<bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
In-Reply-To: <bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [80.67.10.141]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2628;7:kuBo0ouETlz+r/Nq8K0X+TUnqCas4g1Vmp23MilpP59ms1Qbg3GjWpfJO6boaeAcGDu5Obzhd/bURi7bNhg/5WU7dcdRvJ1DhQjQVnQ6ycwNRVClRRJmeVx60ZWIs/t9jv7z8dNPW7IWVL0ndlSJj74E0Oy8OI5rxDxLu1gZaEzjRokaPbZjJP7JhJYlzCm4eBPqHPaLY+xK+NgQpoor9RK+jJd9DBUJe5+aIrj1Qer4FA5YT3A6gesQRQrknd2H
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 739667bf-fe84-434d-92a5-08d5688aeb0c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR06MB2628;
x-ms-traffictypediagnostic: BN6PR06MB2628:
x-microsoft-antispam-prvs: <BN6PR06MB262899AAAF0451A90235C97DBAFB0@BN6PR06MB2628.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2628;
x-forefront-prvs: 056929CBB8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(39830400003)(346002)(189003)(199004)(8936002)(86362001)(102836004)(3280700002)(54906003)(6506007)(33656002)(106356001)(53546011)(55236004)(59450400001)(2950100002)(66066001)(97736004)(82746002)(6116002)(6486002)(5660300001)(6436002)(81156014)(3846002)(316002)(81166006)(8676002)(25786009)(105586002)(2906002)(6916009)(186003)(26005)(229853002)(6512007)(2900100001)(53936002)(575784001)(83716003)(6246003)(99286004)(68736007)(14454004)(77096007)(478600001)(7736002)(4326008)(36756003)(305945005)(3660700001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2628;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cW0LfmULxJd1aDyMBCGKpeXZK/kd+mEksYXjBehw+yEcA+pEMQkpO7USsVY+oOeDTJOhCgvK9/L9LJPhHZFuzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739667bf-fe84-434d-92a5-08d5688aeb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2018 09:13:39.9677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2628
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0V9Dv6e008975



> On 31 Jan 2018, at 16.51, Matias Bjørling <mb@lightnvm.io> wrote:
> 
>> On 01/31/2018 03:06 AM, Javier González wrote:
>> In preparation for the OCSSD 2.0 spec. bad block identification,
>> refactor the current code to generalize bad block get/set functions and
>> structures.
>> Signed-off-by: Javier González <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-init.c | 213 +++++++++++++++++++++++--------------------
>>  drivers/lightnvm/pblk.h      |   6 --
>>  2 files changed, 112 insertions(+), 107 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index a5e3510c0f38..86a94a7faa96 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -365,7 +365,25 @@ static void pblk_luns_free(struct pblk *pblk)
>>      kfree(pblk->luns);
>>  }
>>  -static void pblk_free_line_bitmaps(struct pblk_line *line)
>> +static void pblk_line_mg_free(struct pblk *pblk)
>> +{
>> +    struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> +    int i;
>> +
>> +    kfree(l_mg->bb_template);
>> +    kfree(l_mg->bb_aux);
>> +    kfree(l_mg->vsc_list);
>> +
>> +    for (i = 0; i < PBLK_DATA_LINES; i++) {
>> +        kfree(l_mg->sline_meta[i]);
>> +        pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
>> +        kfree(l_mg->eline_meta[i]);
>> +    }
>> +
>> +    kfree(pblk->lines);
>> +}
>> +
>> +static void pblk_line_meta_free(struct pblk_line *line)
>>  {
>>      kfree(line->blk_bitmap);
>>      kfree(line->erase_bitmap);
>> @@ -382,40 +400,16 @@ static void pblk_lines_free(struct pblk *pblk)
>>          line = &pblk->lines[i];
>>            pblk_line_free(pblk, line);
>> -        pblk_free_line_bitmaps(line);
>> +        pblk_line_meta_free(line);
>>      }
>>      spin_unlock(&l_mg->free_lock);
>>  }
>>  -static void pblk_line_meta_free(struct pblk *pblk)
>> +static int pblk_bb_get_tbl(struct nvm_tgt_dev *dev, struct pblk_lun *rlun,
>> +               u8 *blks, int nr_blks)
>>  {
>> -    struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> -    int i;
>> -
>> -    kfree(l_mg->bb_template);
>> -    kfree(l_mg->bb_aux);
>> -    kfree(l_mg->vsc_list);
>> -
>> -    for (i = 0; i < PBLK_DATA_LINES; i++) {
>> -        kfree(l_mg->sline_meta[i]);
>> -        pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
>> -        kfree(l_mg->eline_meta[i]);
>> -    }
>> -
>> -    kfree(pblk->lines);
>> -}
>> -
>> -static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
>> -{
>> -    struct nvm_geo *geo = &dev->geo;
>>      struct ppa_addr ppa;
>> -    u8 *blks;
>> -    int nr_blks, ret;
>> -
>> -    nr_blks = geo->nr_chks * geo->plane_mode;
>> -    blks = kmalloc(nr_blks, GFP_KERNEL);
>> -    if (!blks)
>> -        return -ENOMEM;
>> +    int ret;
>>        ppa.ppa = 0;
>>      ppa.g.ch = rlun->bppa.g.ch;
>> @@ -423,34 +417,56 @@ static int pblk_bb_discovery(struct nvm_tgt_dev *dev, struct pblk_lun *rlun)
>>        ret = nvm_get_tgt_bb_tbl(dev, ppa, blks);
>>      if (ret)
>> -        goto out;
>> +        return ret;
>>        nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
>> -    if (nr_blks < 0) {
>> -        ret = nr_blks;
>> -        goto out;
>> -    }
>> -
>> -    rlun->bb_list = blks;
>> +    if (nr_blks < 0)
>> +        return -EIO;
>>        return 0;
>> -out:
>> -    kfree(blks);
>> -    return ret;
>> +}
>> +
>> +static void *pblk_bb_get_log(struct pblk *pblk)
>> +{
>> +    struct nvm_tgt_dev *dev = pblk->dev;
>> +    struct nvm_geo *geo = &dev->geo;
>> +    u8 *log;
>> +    int i, nr_blks, blk_per_lun;
>> +    int ret;
>> +
>> +    blk_per_lun = geo->nr_chks * geo->plane_mode;
>> +    nr_blks = blk_per_lun * geo->all_luns;
>> +
>> +    log = kmalloc(nr_blks, GFP_KERNEL);
>> +    if (!log)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    for (i = 0; i < geo->all_luns; i++) {
>> +        struct pblk_lun *rlun = &pblk->luns[i];
>> +        u8 *log_pos = log + i * blk_per_lun;
>> +
>> +        ret = pblk_bb_get_tbl(dev, rlun, log_pos, blk_per_lun);
>> +        if (ret) {
>> +            kfree(log);
>> +            return ERR_PTR(-EIO);
>> +        }
>> +    }
>> +
>> +    return log;
>>  }
>>    static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
>> -            int blk_per_line)
>> +            u8 *bb_log, int blk_per_line)
>>  {
>>      struct nvm_tgt_dev *dev = pblk->dev;
>>      struct nvm_geo *geo = &dev->geo;
>> -    struct pblk_lun *rlun;
>> -    int bb_cnt = 0;
>> -    int i;
>> +    int i, bb_cnt = 0;
>>        for (i = 0; i < blk_per_line; i++) {
>> -        rlun = &pblk->luns[i];
>> -        if (rlun->bb_list[line->id] == NVM_BLK_T_FREE)
>> +        struct pblk_lun *rlun = &pblk->luns[i];
>> +        u8 *lun_bb_log = bb_log + i * blk_per_line;
>> +
>> +        if (lun_bb_log[line->id] == NVM_BLK_T_FREE)
>>              continue;
>>            set_bit(pblk_ppa_to_pos(geo, rlun->bppa), line->blk_bitmap);
>> @@ -460,29 +476,12 @@ static int pblk_bb_line(struct pblk *pblk, struct pblk_line *line,
>>      return bb_cnt;
>>  }
>>  -static int pblk_alloc_line_bitmaps(struct pblk *pblk, struct pblk_line *line)
>> -{
>> -    struct pblk_line_meta *lm = &pblk->lm;
>> -
>> -    line->blk_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>> -    if (!line->blk_bitmap)
>> -        return -ENOMEM;
>> -
>> -    line->erase_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>> -    if (!line->erase_bitmap) {
>> -        kfree(line->blk_bitmap);
>> -        return -ENOMEM;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>  static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
>>  {
>>      struct nvm_tgt_dev *dev = pblk->dev;
>>      struct nvm_geo *geo = &dev->geo;
>>      struct pblk_lun *rlun;
>> -    int i, ret;
>> +    int i;
>>        /* TODO: Implement unbalanced LUN support */
>>      if (geo->nr_luns < 0) {
>> @@ -505,13 +504,6 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
>>          rlun->bppa = luns[lunid];
>>            sema_init(&rlun->wr_sem, 1);
>> -
>> -        ret = pblk_bb_discovery(dev, rlun);
>> -        if (ret) {
>> -            while (--i >= 0)
>> -                kfree(pblk->luns[i].bb_list);
>> -            return ret;
>> -        }
>>      }
>>        return 0;
>> @@ -689,6 +681,26 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
>>      return -ENOMEM;
>>  }
>>  +static int pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
>> +                void *chunk_log, long *nr_bad_blks)
>> +{
>> +    struct pblk_line_meta *lm = &pblk->lm;
>> +
>> +    line->blk_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>> +    if (!line->blk_bitmap)
>> +        return -ENOMEM;
>> +
>> +    line->erase_bitmap = kzalloc(lm->blk_bitmap_len, GFP_KERNEL);
>> +    if (!line->erase_bitmap) {
>> +        kfree(line->blk_bitmap);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    *nr_bad_blks = pblk_bb_line(pblk, line, chunk_log, lm->blk_per_line);
>> +
>> +    return 0;
>> +}
>> +
>>  static int pblk_lines_init(struct pblk *pblk)
>>  {
>>      struct nvm_tgt_dev *dev = pblk->dev;
>> @@ -696,8 +708,9 @@ static int pblk_lines_init(struct pblk *pblk)
>>      struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>      struct pblk_line_meta *lm = &pblk->lm;
>>      struct pblk_line *line;
>> +    void *chunk_log;
>>      unsigned int smeta_len, emeta_len;
>> -    long nr_bad_blks, nr_free_blks;
>> +    long nr_bad_blks = 0, nr_free_blks = 0;
>>      int bb_distance, max_write_ppas, mod;
>>      int i, ret;
>>  @@ -771,13 +784,12 @@ static int pblk_lines_init(struct pblk *pblk)
>>      if (lm->min_blk_line > lm->blk_per_line) {
>>          pr_err("pblk: config. not supported. Min. LUN in line:%d\n",
>>                              lm->blk_per_line);
>> -        ret = -EINVAL;
>> -        goto fail;
>> +        return -EINVAL;
>>      }
>>        ret = pblk_lines_alloc_metadata(pblk);
>>      if (ret)
>> -        goto fail;
>> +        return ret;
>>        l_mg->bb_template = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
>>      if (!l_mg->bb_template) {
>> @@ -821,9 +833,16 @@ static int pblk_lines_init(struct pblk *pblk)
>>          goto fail_free_bb_aux;
>>      }
>>  -    nr_free_blks = 0;
>> +    chunk_log = pblk_bb_get_log(pblk);
>> +    if (IS_ERR(chunk_log)) {
>> +        pr_err("pblk: could not get bad block log (%lu)\n",
>> +                            PTR_ERR(chunk_log));
>> +        ret = PTR_ERR(chunk_log);
>> +        goto fail_free_lines;
>> +    }
>> +
>>      for (i = 0; i < l_mg->nr_lines; i++) {
>> -        int blk_in_line;
>> +        int chk_in_line;
>>            line = &pblk->lines[i];
>>  @@ -835,26 +854,20 @@ static int pblk_lines_init(struct pblk *pblk)
>>          line->vsc = &l_mg->vsc_list[i];
>>          spin_lock_init(&line->lock);
>>  -        ret = pblk_alloc_line_bitmaps(pblk, line);
>> +        ret = pblk_setup_line_meta(pblk, line, chunk_log, &nr_bad_blks);
>>          if (ret)
>> -            goto fail_free_lines;
>> +            goto fail_free_chunk_log;
>>  -        nr_bad_blks = pblk_bb_line(pblk, line, lm->blk_per_line);
>> -        if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line) {
>> -            pblk_free_line_bitmaps(line);
>> -            ret = -EINVAL;
>> -            goto fail_free_lines;
>> -        }
>> -
>> -        blk_in_line = lm->blk_per_line - nr_bad_blks;
>> -        if (blk_in_line < lm->min_blk_line) {
>> +        chk_in_line = lm->blk_per_line - nr_bad_blks;
>> +        if (nr_bad_blks < 0 || nr_bad_blks > lm->blk_per_line ||
>> +                    chk_in_line < lm->min_blk_line) {
>>              line->state = PBLK_LINESTATE_BAD;
>>              list_add_tail(&line->list, &l_mg->bad_list);
>>              continue;
>>          }
>>  -        nr_free_blks += blk_in_line;
>> -        atomic_set(&line->blk_in_line, blk_in_line);
>> +        nr_free_blks += chk_in_line;
>> +        atomic_set(&line->blk_in_line, chk_in_line);
>>            l_mg->nr_free_lines++;
>>          list_add_tail(&line->list, &l_mg->free_list);
>> @@ -862,23 +875,21 @@ static int pblk_lines_init(struct pblk *pblk)
>>        pblk_set_provision(pblk, nr_free_blks);
>>  -    /* Cleanup per-LUN bad block lists - managed within lines on run-time */
>> -    for (i = 0; i < geo->all_luns; i++)
>> -        kfree(pblk->luns[i].bb_list);
>> -
>> +    kfree(chunk_log);
>>      return 0;
>> -fail_free_lines:
>> +
>> +fail_free_chunk_log:
>> +    kfree(chunk_log);
>>      while (--i >= 0)
>> -        pblk_free_line_bitmaps(&pblk->lines[i]);
>> +        pblk_line_meta_free(&pblk->lines[i]);
>> +fail_free_lines:
>> +    kfree(pblk->lines);
>>  fail_free_bb_aux:
>>      kfree(l_mg->bb_aux);
>>  fail_free_bb_template:
>>      kfree(l_mg->bb_template);
>>  fail_free_meta:
>> -    pblk_line_meta_free(pblk);
>> -fail:
>> -    for (i = 0; i < geo->all_luns; i++)
>> -        kfree(pblk->luns[i].bb_list);
>> +    pblk_line_mg_free(pblk);
>>        return ret;
>>  }
>> @@ -922,7 +933,7 @@ static void pblk_free(struct pblk *pblk)
>>      pblk_luns_free(pblk);
>>      pblk_lines_free(pblk);
>>      kfree(pblk->pad_dist);
>> -    pblk_line_meta_free(pblk);
>> +    pblk_line_mg_free(pblk);
>>      pblk_core_free(pblk);
>>      pblk_l2p_free(pblk);
>>  @@ -1110,7 +1121,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>>  fail_free_pad_dist:
>>      kfree(pblk->pad_dist);
>>  fail_free_line_meta:
>> -    pblk_line_meta_free(pblk);
>> +    pblk_line_mg_free(pblk);
>>  fail_free_luns:
>>      pblk_luns_free(pblk);
>>  fail:
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 88720e2441c0..282dfc8780e8 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -201,12 +201,6 @@ struct pblk_rb {
>>    struct pblk_lun {
>>      struct ppa_addr bppa;
>> -
>> -    u8 *bb_list;            /* Bad block list for LUN. Only used on
>> -                     * bring up. Bad blocks are managed
>> -                     * within lines on run-time.
>> -                     */
>> -
>>      struct semaphore wr_sem;
>>  };
>>  
> 
> Looks good to me.
> 
> With respect to the 2.0 implementation. I am thinking that get_bb and set_bb should behave in the following way:
> 
> For get_bb (in nvme/host/lightnvm.c)
> 1.2: Keep the implementation as is.
> 2.0: Use the report chunk command, and redo the get_bb format.
> 
> For set_bb (in nvme/host/lightnvm.c)
> 1.2: Business as usual
> 2.0: Report error.

I have a patches abstracting this, which I think it makes it cleaner. I can push it next week for review. I’m traveling this week. (If you want to get a glimpse I can point you to the code). 

> 
> For 2.0, there will be added a function pointer for get report chunk implementation, where the client can ask for full chunk information. Similarly here, client will fail the function call if the drive is 1.2.
> 
> I hope to post the small 2.0 identify implementation Tomorrow or Friday, and then you can post the report chunk implementation that you have done if you like

Sure. I have patches implementing 2.0 too, but you can push your version. One thing I’d like to get in is a generic geometry structure that simplifies the identify command and puts the logic in the identify path. 

This makes the base group structure from 1.2 go away makes the 1.2 and 2.0 paths easier to maintain at the target level. 

I can point you to the patches tomorrow if you want to align with it. Otherwise, I can just rebase and send them next week. But please, consider this before making a new abstraction to make the 2 specs coexist - most of the work is done already...


> We also need to take a look at the new error codes, which does not align with the 1.2 specification (now that they actually follow the nvme specification ;))

Cool. Let’s maintain the 1.2 errors for compatibility and make the 2.0 path clean - that is nvme compatible ;)

Javier. 
